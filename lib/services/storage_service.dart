import 'dart:convert';

import 'package:bsudoku/models/game_model.dart';
import 'package:bsudoku/models/game_stats_model.dart';
import 'package:bsudoku/models/statisctics_model.dart';
import 'package:bsudoku/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
    late final SharedPreferences __prefs;

    StorageService._create();
    static Future<StorageService> initialize() async {
        StorageService storageService = StorageService._create();
        storageService.__prefs = await SharedPreferences.getInstance();
        return storageService;
    }

    Future<void> saveGame(GameModel gameModel) async {
        await __prefs.setString('game', jsonEncode(gameModel.toJson()));
    }

    Future<void> deleteGame() async {
        try {
            await __prefs.setString('game', '');
        } catch (e) {
            debugPrint('Error while deleting game: $e');
        }
    }

    GameModel? getSavedGame() {
        if (__prefs.containsKey('game')) {
            debugPrint('Getting saved game');

            String jsonString = __prefs.getString('game')!;
            if (jsonString.isNotEmpty) {
                debugPrint('Saved game found');
                try {
                    GameModel gameModel = GameModel.fromJson(jsonDecode(jsonString));
                    return gameModel;
                } catch (e) {
                    debugPrint('Error while getting saved game: $e');
                    return null;
                }
            }
            return null;
        }
        return null;
    }

    Future<void> saveGameStats(GameStatsModel gameStatsModel) async {
        StatisticsModel? statistics = getStatistics(gameStatsModel.difficulty);
        statistics ??= StatisticsModel(statistics: [], statGroups: []);

        if (statistics.statistics.isEmpty || gameStatsModel.isOnGoing) {
            statistics.statistics.add(gameStatsModel);
        } else {
            statistics.updateLast(gameStatsModel);
        }

        try {
            await __prefs.setString('statistics_${gameStatsModel.difficulty}',  jsonEncode(statistics.toJson()));
        } catch (e) {
            debugPrint('Error while saving game stats: $e');
        }
    }

    StatisticsModel? getStatistics(Difficulty difficulty) {
        if (__prefs.containsKey('statistics_$difficulty')) {
            String jsonString = __prefs.getString('statistics_$difficulty')!;
            try {
                StatisticsModel statisticsModel = StatisticsModel.fromJson(jsonDecode(jsonString));
                return statisticsModel;
            } catch (e) {
                debugPrint('Error while getting statistics: $e');
                return null;
            }
        }
        return null;
    }
}
