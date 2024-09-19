import 'package:flutter/material.dart';

class VerticalLines extends StatelessWidget {
    final double borderWidth;
    final Color borderColor;

    const VerticalLines({required this.borderWidth, required this.borderColor, super.key});

    @override
    Widget build(BuildContext context) {
        return Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container( height: double.infinity, width: borderWidth, color: borderColor ),
            Container( height: double.infinity, width: borderWidth, color: borderColor ),
      ],
    );
  }
}