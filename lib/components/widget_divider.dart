import 'package:bsudoku/utils/game_colors.dart';
import 'package:flutter/material.dart';

class WidgetDivider extends StatelessWidget {
    final List<Widget> children;
    final double leftPadding;

    const WidgetDivider({required this.children, this.leftPadding = 0, super.key});

    @override
    Widget build(BuildContext context) {
        return Column(mainAxisSize: MainAxisSize.min,
            children: List.generate(children.length * 2 - 1, (index) {
                if (index % 2 == 0) {
                    return children[(index / 2).floor()];
                } else {
                    return Container( height: 0.8, margin: EdgeInsets.only(left: leftPadding), width: double.infinity, color: GameColors.divider);
                }
            }),
        );
    }
}
