import 'dart:math';

import 'package:bsudoku/components/model_bottom_sheets.dart';
import 'package:bsudoku/models/game_stats_model.dart';
import 'package:bsudoku/models/stat_group_model.dart';
import 'package:bsudoku/models/statisctics_model.dart';
import 'package:bsudoku/services/storage_service.dart';
import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/utils/extentions.dart';
import 'package:bsudoku/utils/game_string.dart';
import 'package:flutter/material.dart';

class StatisticsScreenProvider with ChangeNotifier {
    late StorageService _storageService;
    late StatisticsModel statisticsModel;

    bool loading = true;

    TimeInterval timeInterval = TimeInterval.allTime;

    StatisticsScreenProvider() {
        _init();
    }

    List<GameStatsModel> _getStatisticsByTime() {
        final DateTime now = DateTime.now();
        List<GameStatsModel> gameStats = statisticsModel.statistics;

        if (timeInterval == TimeInterval.allTime) {
            return gameStats;
        } else if (timeInterval == TimeInterval.thisYear) {
            if (gameStats.any((element) => element.dateTime.year == now.year)) {
                return gameStats.where((element) => element.dateTime.year == now.year).toList();
            }
        } else if (timeInterval == TimeInterval.thisMonth) {
            if (gameStats.any((element) => element.dateTime.month == now.month && now.difference(element.dateTime).inDays < 31)) {
                return gameStats.where((element) => element.dateTime.month == now.month).toList();
            }
        } else if (timeInterval == TimeInterval.thisWeek) {
            if (gameStats.any((element) => now.difference(element.dateTime).inDays <= now.weekday)) {
                return gameStats.where((element) => now.difference(element.dateTime).inDays <= now.weekday).toList();
            }
        } else if (timeInterval == TimeInterval.today) {
            if (gameStats.any((element) => now.day == element.dateTime.day && now.difference(element.dateTime).inDays < 1)) {
                return gameStats.where((element) => now.difference(element.dateTime).inDays < 1).toList();
            }
        }
        return [];
    }

    void _setStatGroups() {
        statisticsModel.statGroups.clear();
        final List<GameStatsModel> statisticsByTime = _getStatisticsByTime();

        for (Difficulty difficulty in GameSettings.getDifficulties) {
            List<GameStatsModel> gameStats = [];

            final bool difficultyRecordExists = statisticsByTime.any((element) => element.difficulty == difficulty);

            if (difficultyRecordExists) {
                gameStats = statisticsByTime.where((element) => element.difficulty == difficulty).toList();
            }

            final StatGroupModel statGroupModel = StatGroupModel(difficulty: difficulty, stats: _setStats(gameStats));
            statisticsModel.statGroups.add(statGroupModel);
        }
    }

    List<StatModel> _setStats(List<GameStatsModel> gameStats) {
        List<StatModel> stats = [];

        gameStats.sort((a, b) => a.dateTime.compareTo(b.dateTime));

        int? gamesStarted, gamesWon, winRate, winsWithNoMistakes, bestTime, averageTime, bestScore, averageScore, currentWinStreak, bestWinStreak;

        if (gameStats.isNotEmpty) {
            gamesStarted = gameStats.length;
            gamesWon = gameStats.where((element) => element.won == true).length;
            winRate = ((gamesWon * 100) / gamesStarted).round();
            winsWithNoMistakes = gameStats.where((element) => element.won == true && element.mistakes == 0).length;

            final List<int> times = gameStats.where((element) => element.time != null && element.won == true).toList().map((e) => e.time!).toList();

            bestTime = times.isNotEmpty ? times.reduce(max) : null;
            averageTime = times.isNotEmpty ? times.fold(0, (previousValue, element) => previousValue! + element) : null;

            /// Score
            final List<int> scores = gameStats.where((element) => element.score != null).toList().map((e) => e.score!).toList();

            bestScore = scores.isNotEmpty ? scores.reduce(max) : null;
            averageScore = scores.isNotEmpty ? scores.fold(0, (previousValue, element) => previousValue! + element) : null;

            /// Streaks
            gameStats.removeWhere((element) => element.won == null);

            if (gameStats.every((element) => element.won == true)) {
                currentWinStreak = gameStats.length;
            } else {
                currentWinStreak = gameStats.indexWhere((element) => element.won == false);
                if (currentWinStreak == -1) {
                    currentWinStreak = 0;
                }
            }

            int currentConsecutiveWins = 0;
            bestWinStreak = 0;

            for (int i = 0; i < gameStats.length; i++) {
                if (gameStats[i].won == true) {
                    currentConsecutiveWins++;
                    if (currentConsecutiveWins > bestWinStreak!) {
                        bestWinStreak = currentConsecutiveWins;
                    }
                } else {
                    currentConsecutiveWins = 0;
                }
            }
        }

        /// add Stats
        stats.add(StatModel(index: 0, value: gamesStarted, title: GameStrings.gamesStarted, type: StatisticType.games));
        stats.add(StatModel(index: 1, value: gamesWon, title: GameStrings.gamesWon, type: StatisticType.games ));
        stats.add(StatModel( index: 2, value: winRate != null ? '$winRate%' : null, title: GameStrings.winRate, type: StatisticType.games));
        stats.add(StatModel(index: 3, value: winsWithNoMistakes, title: GameStrings.winsWithNoMistakes, type: StatisticType.games));
        stats.add(StatModel( index: 0, value: bestTime != null ? bestTime.toTimeString() : '-', title: GameStrings.bestTime, type: StatisticType.time,));
        stats.add(StatModel( index: 1, value: averageTime != null ? averageTime.toTimeString() : '-', title: GameStrings.averageTime, type: StatisticType.time));
        stats.add(StatModel(index: 0, value: bestScore, title: GameStrings.bestScore, type: StatisticType.score));
        stats.add(StatModel(index: 1, value: averageScore, title: GameStrings.averageScore, type: StatisticType.score ));
        stats.add(StatModel( index: 0, value: currentWinStreak, title: GameStrings.currentWinStreak, type: StatisticType.streaks ));
        stats.add(StatModel( index: 1, value: bestWinStreak, title: GameStrings.bestWinStreak, type: StatisticType.streaks ));

        return stats;
    }

    StatGroupModel getStatGroup(Difficulty difficulty) {
        List<StatGroupModel> statGroups = statisticsModel.statGroups.where((element) => element.difficulty == difficulty).toList();

        return statGroups.first;
    }

    Future<void> changeTimeInterval() async {
        TimeInterval? selectedTimeInterval;
        try {
            selectedTimeInterval = await ModalBottomSheets.chooseTimeInterval(timeInterval);
        } catch (e) {
            debugPrint(e.toString());
        }

        if (selectedTimeInterval != null && timeInterval != selectedTimeInterval) {
            timeInterval = selectedTimeInterval;
            _setStatGroups();

            notifyListeners();
        }
    }

    void _getAllStatistics() {
        statisticsModel = StatisticsModel(statistics: [], statGroups: []);

        for (Difficulty difficulty in Difficulty.values) {
            StatisticsModel? statistics = _storageService.getStatistics(difficulty);
            if (statistics != null) {
                statisticsModel.statistics.addAll(statistics.statistics);
            }
        }
    }

    Future<void> _init() async {
        _storageService = await StorageService.initialize();

        _getAllStatistics();
        _setStatGroups();

        loading = false;
        notifyListeners();
    }
}
