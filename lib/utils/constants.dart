import 'package:bsudoku/models/board_model.dart';
import 'package:bsudoku/models/cell_model.dart';
import 'package:bsudoku/models/cell_position_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

List<String> months = [
    'January', 'February',  'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December', ];

List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

enum StatisticType { games, time, score, streaks }
enum Difficulty { easy, medium, hard, expert, nightmare }
enum TimeInterval { today, thisWeek, thisMonth, thisYear, allTime }

class UsefulTipModel {
    String title, description;
    IconData iconData;
    Color color;

    UsefulTipModel({ required this.title, required this.description, required this.iconData, required this.color });
}

class UsefulTips {
    static UsefulTipModel getRandomUsefulTip() {
        _getUsefulTips.shuffle();
        return _getUsefulTips[0];
    }

    static final List<UsefulTipModel> _getUsefulTips = [
        UsefulTipModel(
            title: "statistics".tr(),
            description: "statisticsTip".tr(),
            iconData: Icons.bar_chart,
            color: Colors.blue,
        ),
        UsefulTipModel(
            title: "settings".tr(),
            description: "settingsTip".tr(),
            iconData: Icons.settings,
            color: Colors.green,
        ),
        UsefulTipModel(
            title: "difficulty".tr(),
            description: "difficultyTip".tr(),
            iconData: Icons.gamepad,
            color: Colors.red,
        ),
        UsefulTipModel(
            title: "timer".tr(),
            description: "timerTip".tr(),
            iconData: Icons.timer,
            color: Colors.orange,
        ),
        UsefulTipModel(
            title: "notes".tr(),
            description: "notesTip".tr(),
            iconData: Icons.notes,
            color: Colors.purple,
        ),
        UsefulTipModel(
            title: "mistakes".tr(),
            description: "mistakesTip".tr(),
            iconData: Icons.error,
            color: Colors.redAccent,
        ),
    ];
}


class GameSettings {
    static BoardModel createSudokuBoard() {
        List<List<CellModel>> cells = List.generate(9, (y) => List.generate(9,
                    (x) => CellModel(position: CellPositionModel(y: y, x: x), realValue: 0, notes: [],)));

        return BoardModel(cells: cells, movesLog: []);
    }

    static List<StatisticType> get getStatisticTypes => [ StatisticType.games, StatisticType.time, StatisticType.score, StatisticType.streaks ];
    static List<Difficulty> get getDifficulties => Difficulty.values;
    static List<TimeInterval> get getTimeIntervals => TimeInterval.values;
    static int amountOfNumbersGiven(Difficulty difficulty) {
        switch (difficulty) {
            case Difficulty.easy:
                return 38;
            case Difficulty.medium:
                return 30;
            case Difficulty.hard:
                return 28;
            case Difficulty.expert:
                return 22;
            case Difficulty.nightmare:
                return 23;
            default:
                return 30;
        }
    }
}
