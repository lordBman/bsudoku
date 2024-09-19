import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
    final String title;
    final IconData iconData;
    final Color iconColor;
    final Function()? onTap;
    final bool loading;

    const OptionWidget({ super.key, required this.title, required this.iconData, required this.iconColor, this.onTap, this.loading = false });

    @override
    Widget build(BuildContext context) {
        return InkWell( onTap: loading ? null : onTap, borderRadius: GameSizes.getRadius(6),
            child: Padding(padding: GameSizes.getVerticalPadding(0.005),
                child: Row(children: [
                    SizedBox(width: GameSizes.getWidth(0.01)),
                    Container(width: GameSizes.getWidth(0.07), height: GameSizes.getWidth(0.07), padding: GameSizes.getPadding(0.01),
                        decoration: BoxDecoration(color: iconColor, borderRadius: GameSizes.getRadius(6)),
                        child: Center(child: FittedBox(child: Icon(iconData, color: Colors.white))),
                    ),
                    SizedBox(width: GameSizes.getWidth(0.04)),
                    Text(title, style: GameTextStyles.optionButtonTitle.copyWith(fontSize: GameSizes.getWidth(0.04))),
                    const Spacer(),
                    Icon(Icons.keyboard_arrow_right, color: GameColors.greyColor, size: GameSizes.getWidth(0.07)),
                ])
        ));
    }
}
