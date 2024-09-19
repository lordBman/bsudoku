import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
    final bool isPaused;
    final Function() onPressed;

    const PauseButton({required this.isPaused, required this.onPressed, super.key});

    @override
    Widget build(BuildContext context) {
        return SizedBox(width: GameSizes.getWidth(0.085),
            child: ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: EdgeInsets.zero, backgroundColor: GameColors.pauseButton),
                child: Icon(isPaused ? Icons.play_arrow : Icons.pause_outlined, color: GameColors.pauseIcon, size: GameSizes.getWidth(0.06)),
            ),
        );
    }
}