import 'package:bsudoku/components/widget_divider.dart';
import 'package:bsudoku/models/option_button_model.dart';
import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_routes.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ModalBottomSheets {
    static Future<dynamic> chooseTimeInterval(TimeInterval timeInterval) async {
        List<TimeInterval> options = List.from(GameSettings.getTimeIntervals);
        options.add(timeInterval);

        return await __showOptions(options: List.generate(options.length, (index) {
            TimeInterval intervalOption = options[index];
            bool last = index == options.length - 1;

            final bool isSelected = intervalOption.name == timeInterval.name && !last;
            final String title = last ? "cancel".tr() : intervalOption.name.toLowerCase().tr();

            return OptionButtonModel(onTap: () => intervalOption, selected: isSelected, title: title);
        }));
    }

    static Future<dynamic> chooseDifficulty({Difficulty? restartDifficulty}) async {
        List<Difficulty> options = List.from(GameSettings.getDifficulties);
        final bool restartButton = restartDifficulty != null;

        if (restartButton) options.add(restartDifficulty);

        return await __showOptions(options: List.generate(options.length, (index) {
            final String title = index == options.length - 1 && restartButton ? "restart".tr() : options[index].name.toLowerCase().tr();

            return OptionButtonModel(title: title, onTap: () => options[index]);
        }));
    }

    static Future<dynamic> __showOptions({required List<OptionButtonModel> options}) {
        const double radius = 28;
        final double leadingWidth = GameSizes.getWidth(0.15);
        final bool leading = options.any((element) => element.selected);

        return showModalBottomSheet(context: GameRoutes.navigatorKey.currentContext!, backgroundColor: Colors.transparent, enableDrag: false, builder: (context) {
            return Container(margin: GameSizes.getPadding(0.02), decoration: BoxDecoration(color: Colors.white, borderRadius: GameSizes.getRadius(radius)),
                child: WidgetDivider(leftPadding: leading ? leadingWidth - 3 : 0, children: List.generate(options.length, (index) {
                    final OptionButtonModel optionButton = options[index];

                    BorderRadius borderRadius = BorderRadius.zero;
                    if (index == 0) {
                        borderRadius = const BorderRadius.only(topLeft: Radius.circular(radius), topRight: Radius.circular(radius));
                    } else if (index == options.length - 1) {
                        borderRadius = const BorderRadius.only(bottomLeft: Radius.circular(radius), bottomRight: Radius.circular(radius));
                    }

                    return Material(borderRadius: GameSizes.getRadius(28),
                        child: InkWell(highlightColor: GameColors.whiteButtonForeground,
                            onTap: () => Navigator.pop(context, optionButton.onTap()),
                            borderRadius: borderRadius,
                            child: Container(width: double.infinity, padding: GameSizes.getVerticalPadding(0.02), child: Row(children: [
                                if (leading) ...[
                                    SizedBox(width: leadingWidth, child: Visibility(visible: optionButton.selected,
                                        child: Center(child: Icon(Icons.done, color: GameColors.roundedButton, size: GameSizes.getWidth(0.06))),
                                    )),
                                ],
                                Expanded( child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: leading ? CrossAxisAlignment.start : CrossAxisAlignment.center, children: [
                                    Text(optionButton.title, style: TextStyle(color: GameColors.roundedButton, fontWeight: FontWeight.w400, fontSize: GameSizes.getWidth(0.045))),
                                    if (optionButton.subTitle != null) ...[
                                        Text(optionButton.title, style: TextStyle(color: GameColors.roundedButton, fontWeight: FontWeight.w400, fontSize: GameSizes.getWidth(0.03)),),
                                    ],
                                ])),
                            ])),
                        ),
                    );
                })));
        });
    }
}
