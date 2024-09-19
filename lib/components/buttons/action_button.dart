import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class ActionIcon extends StatelessWidget {
    final IconData iconData;

    const ActionIcon(this.iconData, {super.key});

    @override
    Widget build(BuildContext context) {
        return Align(alignment: Alignment.topCenter,
            child: Padding( padding: EdgeInsets.only(top: GameSizes.getWidth(0.03)),
                child: Icon(iconData, color: GameColors.actionButton, size: GameSizes.getWidth(0.1)),
            ),
        );
    }
}

class ActionButton extends StatelessWidget {
    final String title;
    final Widget iconWidget;
    final Function() onTap;

    const ActionButton({ super.key, required this.title, required this.iconWidget, required this.onTap });

    @override
    Widget build(BuildContext context) {
        return Expanded(
            child: InkWell(onTap: onTap, borderRadius: GameSizes.getRadius(10),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    iconWidget,
                    SizedBox(height: GameSizes.getHeight(0.005)),
                    Text(title, textAlign: TextAlign.center, style: GameTextStyles.actionButton.copyWith(fontSize: GameSizes.getWidth(0.035)))
                ]),
            ),
        );
    }
}
