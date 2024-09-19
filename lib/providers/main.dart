import 'package:bsudoku/components/model_bottom_sheets.dart';
import 'package:bsudoku/models/game_model.dart';
import 'package:bsudoku/services/storage_service.dart';
import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/utils/extentions.dart';
import 'package:bsudoku/utils/game_routes.dart';
import 'package:flutter/material.dart';

class MainScreenProvider with ChangeNotifier {
    GameModel? savedGame;
    bool get isThereASavedGame => savedGame != null;
    String get continueGameButtonText => isThereASavedGame ? '${savedGame!.time.toTimeString()} - ${savedGame!.difficulty.name}' : '';

    MainScreenProvider({this.savedGame}) {
        _init();
    }

    Future<void> _init() async {
        StorageService storageService = await StorageService.initialize();
        savedGame = storageService.getSavedGame();
        notifyListeners();
    }
    
    Future<void> newGame() async {
        Difficulty? newGameDifficulty = await ModalBottomSheets.chooseDifficulty();

        if (newGameDifficulty != null) {
            final GameModel gameModel = GameModel(sudokuBoard: GameSettings.createSudokuBoard(), difficulty: newGameDifficulty);

            GameRoutes.goTo(GameRoutes.gameScreen, args: gameModel);
        }
    }

    void continueGame() {
        if (isThereASavedGame) {
            GameRoutes.goTo(GameRoutes.gameScreen, args: savedGame);
        }
    }
}
