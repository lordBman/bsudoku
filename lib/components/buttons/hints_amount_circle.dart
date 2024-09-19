import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class HintsAmountCircle extends StatelessWidget {
    final int hints;

    const HintsAmountCircle({required this.hints, super.key});

    @override
    Widget build(BuildContext context) {
        String hintText = hints.toString();

        return Positioned( right: GameSizes.getWidth(0.02), child: Visibility(visible: hints > 0,
            child: Container(width: GameSizes.getWidth(0.12), padding: GameSizes.getPadding(0.005),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Container(padding: GameSizes.getPadding(0.003), decoration: BoxDecoration(shape: BoxShape.circle, color: GameColors.actionInfoBg),
                    child: Center(child: Text(hintText, style: TextStyle(color: GameColors.actionInfoText, fontWeight: FontWeight.w600, fontSize: GameSizes.getWidth(0.04)))),
                ),
            )
        ));
    }
}
