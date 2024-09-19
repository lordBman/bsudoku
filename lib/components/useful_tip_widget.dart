import 'package:bsudoku/components/useful_tip_divider.dart';
import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class UsefulTipWidget extends StatelessWidget {
    final UsefulTipModel usefulTipModel;

    const UsefulTipWidget({super.key, required this.usefulTipModel});

    @override 
    Widget build(BuildContext context) {
        return Column(children: [
            const UsefulTipDivider(),
            Container(width: double.infinity, padding: GameSizes.getSymmetricPadding(0.045, 0.03), margin: GameSizes.getHorizontalPadding(0.05),
                decoration: BoxDecoration(color: GameColors.usefulTipBg, borderRadius: GameSizes.getRadius(12)),
                child: Column(children: [
                    Icon(usefulTipModel.iconData, color: usefulTipModel.color, size: GameSizes.getWidth(0.1)),
                    SizedBox(height: GameSizes.getHeight(0.015)),
                    Text( usefulTipModel.title, style: TextStyle(color: GameColors.usefulTipTitle, fontWeight: FontWeight.bold, fontSize: GameSizes.getWidth(0.045))),
                    SizedBox(height: GameSizes.getHeight(0.015)),
                    Text( usefulTipModel.description, textAlign: TextAlign.center, style: TextStyle(color: GameColors.usefulTipContent, fontSize: GameSizes.getWidth(0.035))),
                ]),
            ),
        ]);
    }
}
