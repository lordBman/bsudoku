import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class UsefulTipDivider extends StatelessWidget {
    const UsefulTipDivider({super.key});

    @override
    Widget build(BuildContext context) {
        return Padding( padding: GameSizes.getVerticalPadding(0.02).copyWith(top: GameSizes.getHeight(0.02)), child: Row(children: [
            Expanded(child: Container(height: 1, color: GameColors.divider)),
            Padding( padding: GameSizes.getHorizontalPadding(0.015),
                child: Text( "usefulTip".tr(), style: GameTextStyles.dividerText.copyWith(fontSize: GameSizes.getWidth(0.03)))),
            Expanded(child: Container(height: 1, color: GameColors.divider)),
        ]));
    }
}