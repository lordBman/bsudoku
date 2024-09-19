import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
    final IconData icon;
    final Function()? onPressed;

    const CustomIconButton({super.key, required this.icon, this.onPressed});

    @override 
    Widget build(BuildContext context) {
        return CircleAvatar(backgroundColor: GameColors.appBarActions, radius: GameSizes.getWidth(0.06),
            child: IconButton(onPressed: onPressed, iconSize: GameSizes.getWidth(0.07), icon: Icon(icon, color: Colors.white)));
    }
}