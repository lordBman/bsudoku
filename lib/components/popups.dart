import 'package:bsudoku/components/buttons/rounded_button.dart';
import 'package:bsudoku/components/popup_game_stats.dart';
import 'package:bsudoku/components/useful_tip_widget.dart';
import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_routes.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Popup {
    static Future<void> gameOver({required Function() onNewGame, required Function() onExit}) {
        Widget content = Padding( padding: GameSizes.getSymmetricPadding(0.05, 0.02).copyWith(bottom: GameSizes.getHeight(0.02)),
            child: Text("gameOverText".tr(),  textAlign: TextAlign.center,
                style: TextStyle(color: GameColors.popupContentText, fontSize: GameSizes.getWidth(0.04))));

        List<Widget> actions = [
            RoundedButton( whiteButton: true, buttonText: "exit".tr(), icon: Icons.exit_to_app, onPressed: () {
                onExit();
                Navigator.pop(GameRoutes.navigatorKey.currentContext!);
            }),
            RoundedButton( buttonText: "newGame".tr(), onPressed: () {
                Navigator.pop(GameRoutes.navigatorKey.currentContext!);
                onNewGame();
            }),
        ];
        return __showDialog( title: "gameOver".tr(), content: content, actions: actions);
    }

    static void gamePaused({ required int time, required int mistakes, required Difficulty difficulty, required Function() onResume }) {
        final UsefulTipModel usefulTipModel = UsefulTips.getRandomUsefulTip();

        Widget content = Column(children: [
            PopupGameStats(time: time, mistakes: mistakes, difficulty: difficulty),
            UsefulTipWidget(usefulTipModel: usefulTipModel),
        ]);

        List<Widget> actions = [
            RoundedButton(buttonText: "resumeGame".tr(), onPressed: () {
                onResume();
                Navigator.pop(GameRoutes.navigatorKey.currentContext!);
            })
        ];

        __showDialog(title: "pause".tr(), content: content, actions: actions);
    }

    static Future<void> __showDialog({ required String title, required Widget content, required List<Widget> actions, bool barrierDismissible = false,}) async {
        return showDialog<void>(context: GameRoutes.navigatorKey.currentContext!, barrierDismissible: barrierDismissible,
            builder: (BuildContext context) {
                return PopScope(canPop: false, child: Dialog( insetPadding: GameSizes.getHorizontalPadding(0.05),
                    shape: RoundedRectangleBorder(borderRadius: GameSizes.getRadius(22)), alignment: Alignment.center,
                    backgroundColor: Colors.white,
                    child: Padding( padding: GameSizes.getVerticalPadding(0.02),
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                            SizedBox(height: GameSizes.getHeight(0.01)),
                            Center( child: Text(title, style: GameTextStyles.popupTitle.copyWith(fontSize: GameSizes.getWidth(0.065)))),
                            SizedBox(height: GameSizes.getHeight(0.01)),
                            content,
                            SizedBox(height: GameSizes.getHeight(0.01)),
                            Padding(padding: GameSizes.getSymmetricPadding(0.05, 0.005),
                                child: Column(children: List<Widget>.generate(actions.length, (index) => Padding(
                                        padding: index < actions.length - 1 ? EdgeInsets.only(bottom: GameSizes.getHeight(0.015)) : EdgeInsets.zero,
                                        child: actions[index]))),
                            ),
                        ]),
                    ),
                ));
        });
    }
}
