import 'package:bsudoku/components/game_info_widget.dart';
import 'package:bsudoku/utils/constants.dart';
import 'package:bsudoku/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PopupGameStats extends StatelessWidget {
    final int time;
    final int mistakes;
    final Difficulty difficulty;

    const PopupGameStats({ super.key, required this.time, required this.mistakes, required this.difficulty });

    @override
    Widget build(BuildContext context) {
        return Padding( padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GameInfoWidget( title: "time".tr(), value: time.toTimeString(), forPopup: true),
                GameInfoWidget( title: "mistakes".tr(), value: '$mistakes/3', forPopup: true),
                GameInfoWidget( title: "difficulty".tr(), value: difficulty.name.toLowerCase().tr(), forPopup: true),
            ])
        );
    }
}
