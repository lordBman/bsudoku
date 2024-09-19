import 'package:bsudoku/models/game_stats_model.dart';
import 'package:bsudoku/models/stat_group_model.dart';
import 'package:bsudoku/utils/constants.dart';

class StatisticsModel {
    List<GameStatsModel> statistics;
    List<StatGroupModel> statGroups;

    StatisticsModel({ required this.statistics, required this.statGroups,});
    factory StatisticsModel.fromJson(Map<String, dynamic> json) {
        return StatisticsModel(
            statistics: List<GameStatsModel>.from(json['statistics'].map((e) => GameStatsModel.fromJson(e))),
            statGroups: [],
        );
    }

    List<StatGroupModel> getStatGroups(Difficulty difficulty) {
        return statGroups.where((gameStats) => gameStats.difficulty == difficulty).toList();
    }

    void updateLast(GameStatsModel gameStatsModel) {
        statistics.sort((a, b) => a.startTime.compareTo(b.startTime));
        statistics.last = gameStatsModel;
    }

    Map<String, dynamic> toJson() => {
        'statistics': statistics.map((e) => e.toJson()).toList(),
    };
}
