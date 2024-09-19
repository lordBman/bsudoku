import 'package:bsudoku/components/model_bottom_sheets.dart';
import 'package:bsudoku/models/game_model.dart';
import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/utils/game_routes.dart';
import 'package:flutter/material.dart';

class WinScreenProvider with ChangeNotifier {
    final GameModel gameModel;

    WinScreenProvider(GameModel gameModelP): gameModel = gameModelP;

    Future<void> newGame() async {
        Difficulty? newGameDifficulty = await ModalBottomSheets.chooseDifficulty();
        if (newGameDifficulty != null) {
            final GameModel gameModel = GameModel(sudokuBoard: GameSettings.createSudokuBoard(), difficulty: newGameDifficulty);

            GameRoutes.goTo(GameRoutes.gameScreen, args: gameModel);
        }
    }
}