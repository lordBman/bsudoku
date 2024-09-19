import 'package:bsudoku/components/app_bar_action_button.dart';
import 'package:bsudoku/utils/game_routes.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class IosBackButton extends StatelessWidget {
    final VoidCallback? onPressed;
    final double? iconSize;

    const IosBackButton({super.key, this.onPressed, this.iconSize});

    @override
    Widget build(BuildContext context) {
        return AppBarActionButton(icon: Icons.arrow_back_ios_new, onPressed: () => GameRoutes.back(), iconSize: iconSize ?? GameSizes.getHeight(0.025));
    }
}