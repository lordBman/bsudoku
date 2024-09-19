import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class GameInfoWidget extends StatelessWidget {
    final String title, value;
    final CrossAxisAlignment crossAxisAlignment;
    final bool forPopup;

    const GameInfoWidget({ required this.title, required this.value, this.crossAxisAlignment = CrossAxisAlignment.center, this.forPopup = false, super.key });

    @override
    Widget build(BuildContext context) {
        return Expanded(child: Column( crossAxisAlignment: crossAxisAlignment, children: [
            Text( title, style: forPopup ? GameTextStyles.popupInfoTitle.copyWith(fontSize: GameSizes.getWidth(0.035))
                  : GameTextStyles.gameInfoTitle.copyWith(fontSize: GameSizes.getWidth(0.033))),
            SizedBox(height: forPopup ? GameSizes.getHeight(0.005) : GameSizes.getHeight(0.002)),
            Text( value, style: forPopup ? GameTextStyles.popupInfoValue.copyWith(fontSize: GameSizes.getWidth(0.043)) : GameTextStyles.gameInfoTitle.copyWith(fontSize: GameSizes.getWidth(0.032))),
        ]));
    }
}
