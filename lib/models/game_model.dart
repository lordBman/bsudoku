import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/models/board_model.dart';

class GameModel{
    BoardModel sudokuBoard;
    Difficulty difficulty;

    bool dailyChallenge;
    bool get isDailyChallenge => dailyChallenge;

    int mistakes, score, time, hints;
    bool get isOnGoingGame => time > 0;

    GameModel({ required this.difficulty, required this.sudokuBoard, this.dailyChallenge = false, this.mistakes = 0, this.score = 0, this.time = 0, this.hints = 3,});
    factory GameModel.fromJson(Map<String, dynamic> json) {
        return GameModel(
            sudokuBoard: BoardModel.fromJson(json['sudokuBoard']),
            difficulty: getDifficulty(json['difficulty']!),
            mistakes: json['mistakes'], score: json['score'],
            time: json['time'], hints: json['hints'],
        );
    }

    Map<String, dynamic> toJson() => {
        'sudokuBoard': sudokuBoard.toJson(), 'difficulty': difficulty.name,
        'mistakes': mistakes, 'score': score,  'time': time, 'hints': hints,
    };

    static Difficulty getDifficulty(String difficulty) {
        return GameSettings.getDifficulties.firstWhere((element) => element.name == difficulty);
    }
}