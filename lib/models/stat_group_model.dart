import 'package:bsudoku/utils/constants.dart';

class StatModel {
    final int index;
    final dynamic value;
    final String title;
    final StatisticType type;

    StatModel({ required this.index, required this.value, required this.title, required this.type });
}

class StatGroupModel {
    final Difficulty difficulty;
    final List<StatModel> stats;

    StatGroupModel({ required this.difficulty, required this.stats });

    void sortStats() {
        stats.sort((a, b) => a.index.compareTo(b.index));
    }

    List<StatModel> getStats(StatisticType statisticType) {
        return stats.where((stat) => stat.type == statisticType).toList();
    }
}