import 'package:bsudoku/utils/game_routes.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
    final String text;
    final Function()? onPressed;

    const CustomTextButton({ super.key, required this.text, this.onPressed });

    @override
    Widget build(BuildContext context) {
        return TextButton( onPressed: onPressed ?? () => GameRoutes.back(),
            style: ButtonStyle(overlayColor: WidgetStateProperty.all(Colors.transparent), foregroundColor: WidgetStateProperty.all(Colors.white),),
            child: Text(text, style: GameTextStyles.customTextButtonText.copyWith(fontSize: GameSizes.getWidth(0.038))),
        );
    }
}