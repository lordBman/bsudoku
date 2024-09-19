import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/utils/extentions.dart';

class GameStatsModel {
    final DateTime dateTime, startTime;
    final Difficulty difficulty;
    final bool? won;
    bool get isOnGoing => won == null;

    final int? score, time, mistakes;

    GameStatsModel({ required this.dateTime, required this.startTime, required this.difficulty, this.won, this.score, this.time, this.mistakes });
    factory GameStatsModel.fromJson(Map<String, dynamic> json) {
        return GameStatsModel(
            dateTime: DateTime.parse(json['dateTime']),
            startTime: DateTime.parse(json['startTime']),
            difficulty: json['difficulty'].toString().toDifficulty(),
            won: json['won']!, score: json['score']!, time: json['time']!, mistakes: json['mistakes']!,
        );
    }

  Map<String, String> toJson() => {
    'dateTime': dateTime.toString(),
    'startTime': startTime.toString(),
    'difficulty': difficulty.name,
    'won': '$won',
    'score': '$score',
    'time': '$time',
    'mistakes': '$mistakes',
  };

  @override
  String toString() => toJson().toString();
}
