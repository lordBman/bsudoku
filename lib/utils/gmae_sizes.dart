import 'package:flutter/material.dart';

class GameSizes {
    static late double __screenWidth, __screenHeight;
    static double get width => __screenWidth;
    static double get height => __screenHeight;

    static late EdgeInsets __padding;
    static double get bottomPadding => __padding.bottom;
    static double get topPadding => __padding.top;

    static BorderRadius borderRadius = BorderRadius.circular(0);

    static void init(BuildContext context) {
        final size = MediaQuery.sizeOf(context);
        __screenWidth = size.width;
        __screenHeight = size.height;
        __padding = MediaQuery.paddingOf(context);
    }

    static BorderRadius getRadius(double radius) {
        final double value = __screenWidth < 500 ? radius : radius * 2;
        return BorderRadius.circular(value);
    }

    static double getWidth(double percent) => __screenWidth * percent;
    static double getHeight(double percent) => __screenHeight * percent;
    static EdgeInsets getPadding(double percent) => EdgeInsets.all(getWidth(percent));
    static EdgeInsets getHorizontalPadding(double percent) => EdgeInsets.symmetric(horizontal: getWidth(percent));
    static EdgeInsets getVerticalPadding(double percent) => EdgeInsets.symmetric(vertical: getHeight(percent));
    static EdgeInsets getSymmetricPadding(double horizontal, double vertical) {
        return EdgeInsets.symmetric( horizontal: getWidth(horizontal), vertical: getHeight(vertical));
    }
}
