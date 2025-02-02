import 'package:bsudoku/components/buttons/rounded_button.dart';
import 'package:bsudoku/components/horizontal_lines.dart';
import 'package:bsudoku/components/option_group_widget.dart';
import 'package:bsudoku/components/vertical_lines.dart';
import 'package:bsudoku/models/board_model.dart';
import 'package:bsudoku/models/cell_model.dart';
import 'package:bsudoku/models/game_model.dart';
import 'package:bsudoku/providers/win.dart';
import 'package:bsudoku/screens/game.dart';
import 'package:bsudoku/utils/extentions.dart';
import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_routes.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WinScreen extends StatelessWidget {
    final GameModel gameModel;

    const WinScreen({ super.key, required this.gameModel});

    @override
    Widget build(BuildContext context) {
        return ChangeNotifierProvider<WinScreenProvider>(create: (context) => WinScreenProvider(gameModel),
            child: Consumer<WinScreenProvider>(builder: (context, provider, _) {
               return PopScope(canPop: false,
                  child: Scaffold(backgroundColor: GameColors.winScreenBg,
                      appBar: AppBar(elevation: 0, toolbarHeight: 0, backgroundColor: Colors.transparent),
                      body: CustomScrollView(shrinkWrap: false, physics: const PageScrollPhysics(), slivers: [
                          SliverFillRemaining( hasScrollBody: false,
                              child: Padding( padding: GameSizes.getHorizontalPadding(0.05), child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                                    Padding( padding: GameSizes.getHorizontalPadding(0.05).copyWith(top: GameSizes.getHeight(0.02)),
                                      child: Text("levelCompleted".tr(), style: GameTextStyles.winScreenHeader.copyWith(fontSize: GameSizes.getWidth(0.07)))),
                                    MiniSudokuBoard(boardModel: provider.gameModel.sudokuBoard),
                                    const Spacer(),
                                    LevelStatistics(gameModel: provider.gameModel),
                                    NewGameButton(onPressed: () => provider.newGame()),
                                    MainButton(onPressed: () => GameRoutes.goTo(GameRoutes.navigationBar)),
                              ])),
                          )
                      ]),
                  )
               );
            })
        );
    }
}

class MainButton extends StatelessWidget {
    const MainButton({required this.onPressed, super.key});

    final Function() onPressed;

    @override
    Widget build(BuildContext context) {
        return Padding(padding: GameSizes.getSymmetricPadding(0.05, 0.015),
            child: TextButton(onPressed: onPressed,
                child: Text("home".tr(), style: GameTextStyles.mainTextButton.copyWith(fontSize: GameSizes.getWidth(0.04)))),
        );
    }
}

class NewGameButton extends StatelessWidget {
    final Function() onPressed;

    const NewGameButton({required this.onPressed, super.key});

    @override
    Widget build(BuildContext context) {
        return SizedBox(height: GameSizes.getHeight(0.075),
            child: Padding(padding: GameSizes.getHorizontalPadding(0.05),
                child: RoundedButton(buttonText: "newGame".tr(), onPressed: onPressed, whiteButton: true)));
    }
}

class LevelStatistics extends StatelessWidget {
    final GameModel gameModel;

    const LevelStatistics({required this.gameModel, super.key});

    @override
    Widget build(BuildContext context) {
        return Column(children: [
            Padding(padding: GameSizes.getPadding(0.01),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text("statistics".tr(), style: GameTextStyles.levelStatisticsTitle.copyWith(fontSize: GameSizes.getWidth(0.04))),
                    InkWell(onTap: () => GameRoutes.goTo(GameRoutes.navigationBar, args: [1]), borderRadius: GameSizes.getRadius(16),
                        child: Container(padding: GameSizes.getSymmetricPadding(0.02, 0.005),
                            decoration: BoxDecoration(borderRadius: GameSizes.getRadius(16), color: GameColors.translucentWhite),
                            child: Text("seeAll".tr(), style: GameTextStyles.seeAll.copyWith(fontSize: GameSizes.getWidth(0.035))),
                        ),
                    ),
                ]),
            ),
            // PromotionContainer(gameModel: gameModel),
            OptionGroup(bgColor: GameColors.translucentWhite, dividerColor: Colors.white, options: [
                StatRowWidget(icon: Icons.bar_chart, title: "difficulty".tr(), value: gameModel.difficulty.name.toLowerCase().tr()),
                StatRowWidget(icon: Icons.stars_rounded, title: "score".tr(), value: gameModel.score.toString()),
                StatRowWidget(icon: Icons.timer, title: "time".tr(), value: gameModel.time.toInt().toTimeString()),
            ]),
            SizedBox(height: GameSizes.getHeight(0.02))
        ]);
    }
}

class PromotionContainer extends StatelessWidget {
    final GameModel gameModel;

    const PromotionContainer({super.key, required this.gameModel });

    @override
    Widget build(BuildContext context) {
        return Container(width: double.infinity, alignment: Alignment.center, padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
            decoration: BoxDecoration(color: GameColors.translucentWhite, borderRadius: BorderRadius.circular(13)),
      // child: PromotionText(
      //   time: gameModel.time,
      //   faster: true,
      //   difficulty: gameModel.difficulty,
      //   newBestTime: newBestTime,
      //   timeDifference: timeDifference,
      // ),
    );
  }
}

class StatRowWidget extends StatelessWidget {
    final IconData icon;
    final String title;
    final String value;

    const StatRowWidget({required this.icon, required this.title, required this.value, super.key });

    @override
    Widget build(BuildContext context) {
        return Padding(padding: GameSizes.getSymmetricPadding(0.02, 0.01), child: Row(children: [
            Icon(icon, color: Colors.white, size: GameSizes.getWidth(0.07)),
            SizedBox(width: GameSizes.getWidth(0.03)),
            Text(title, style: GameTextStyles.statRowText.copyWith(fontSize: GameSizes.getWidth(0.04))),
            const Spacer(),
            Text(value, style: GameTextStyles.statRowText.copyWith(fontSize: GameSizes.getWidth(0.04))),
        ]));
    }
}

// class PromotionText extends StatelessWidget {
//   const PromotionText({
//     super.key,
//     required this.time,
//     required this.faster,
//     required this.difficulty,
//     required this.newBestTime,
//     required this.timeDifference,
//   });

//   final int time;
//   final bool faster;
//   final bool newBestTime;
//   final int timeDifference;
//   final Difficulty difficulty;

//   @override
//   Widget build(BuildContext context) {
//     if (newBestTime) {
//       return RichText(
//         textAlign: TextAlign.center,
//         text: TextSpan(
//           text: GameStrings.youSetANew,
//           style: GameTextStyles.promotionText,
//           children: [
//             TextSpan(
//               text: GameStrings.bestTimeB,
//               style: GameTextStyles.promotionTextGold,
//             ),
//             const TextSpan(
//               text: GameStrings.forThe,
//             ),
//             TextSpan(
//               text: difficulty.name,
//             ),
//             const TextSpan(
//               text: GameStrings.difficultyLevel,
//             ),
//             TextSpan(
//               text: time.toTimeString(),
//               style: GameTextStyles.promotionTextGold,
//             ),
//             const TextSpan(
//               text: '!',
//             ),
//           ],
//         ),
//       );
//     }

//     return RichText(
//       textAlign: TextAlign.center,
//       text: TextSpan(
//         text: GameStrings.youSolvedThisPuzzle,
//         style: GameTextStyles.promotionText,
//         children: [
//           TextSpan(
//             text:
//                 '${timeDifference.toTimeString()} ${faster ? GameStrings.faster : GameStrings.slower}',
//             style: GameTextStyles.promotionTextGold,
//           ),
//           const TextSpan(
//             text: GameStrings.thanYourAverage,
//           ),
//         ],
//       ),
//     );
//   }
// }

class MiniSudokuBoard extends StatelessWidget {
    const MiniSudokuBoard({required this.boardModel, super.key});

    final BoardModel boardModel;

    @override
    Widget build(BuildContext context) {
        final double borderWidth = GameSizes.getWidth(0.004);
        final double cellBorderWidth = GameSizes.getWidth(0.003);

        return Container(width: GameSizes.getWidth(0.65), height: GameSizes.getWidth(0.65),
            padding: GameSizes.getPadding(0.03), margin: GameSizes.getVerticalPadding(0.04),
            decoration: BoxDecoration(color: Colors.white, borderRadius: GameSizes.getRadius(10)),
            child: Container(decoration: BoxDecoration(border: Border.all(width: borderWidth)),
                child: Stack(children: [
                    VerticalLines(borderWidth: borderWidth, borderColor: GameColors.boardBorder),
                    HorizontalLines(borderWidth: borderWidth, borderColor: GameColors.boardBorder),
                    GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: borderWidth, crossAxisSpacing: borderWidth), itemCount: 9, itemBuilder: (context, boxIndex) {
                            return Stack(alignment: Alignment.topCenter, children: [
                                VerticalLines(borderWidth: cellBorderWidth, borderColor: GameColors.cellBorder),
                                HorizontalLines(borderWidth: cellBorderWidth, borderColor: GameColors.cellBorder),
                                GridView.builder(padding: EdgeInsets.zero, physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: cellBorderWidth, crossAxisSpacing: cellBorderWidth), itemCount: 9, itemBuilder: (context, boxCellIndex) {
                                        CellModel cell = boardModel.getCellByBoxIndex(boxIndex, boxCellIndex);
                                        return CellValueText(cell: cell);
                                    }),
                            ]);
                    }),
                ]),
            ),
        );
    }
}
