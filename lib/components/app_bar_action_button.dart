import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class AppBarActionButton extends StatelessWidget {
    final IconData icon;
    final Function() onPressed;
    final double? iconSize;

    const AppBarActionButton({required this.icon, required this.onPressed, this.iconSize, super.key});

    @override
    Widget build(BuildContext context) {
        return IconButton(onPressed: onPressed,
            icon: Icon(icon, color: GameColors.appBarActions),
            iconSize: iconSize ?? GameSizes.getWidth(0.06),
            visualDensity: VisualDensity.compact,
            // splashRadius: iconSize,
            padding: GameSizes.getSymmetricPadding(0.01, 0.001),
        );
    }
}