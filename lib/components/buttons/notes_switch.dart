import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotesSwitchWidget extends StatelessWidget {
  final bool notesOn;
  const NotesSwitchWidget({required this.notesOn, super.key});

  @override
  Widget build(BuildContext context) {
    final String text = notesOn ? "notesOn".tr() : "notesOff".tr();
    final Color bgColor =
    notesOn ? GameColors.actionInfoBg : GameColors.actionInfoBgDeactive;

    return Positioned(
      right: GameSizes.getWidth(0.01),
      child: Container(
        width: GameSizes.getWidth(0.1),
        padding: GameSizes.getPadding(0.005),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: GameSizes.getRadius(16),
        ),
        child: Container(
          padding: GameSizes.getVerticalPadding(0.004),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: GameSizes.getRadius(16),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: GameColors.actionInfoText,
                fontWeight: FontWeight.w700,
                fontSize: GameSizes.getWidth(0.025),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
