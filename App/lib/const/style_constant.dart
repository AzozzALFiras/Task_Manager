// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class appStyle {
//* Colors
  static const Color primaryColor = Colors.teal;
  static const Color primaryBgColor = Color(0xffFFFFFF);
  static const Color grayColor = Color(0xffE2E0DF);
  static const Color grayColor2 = Color(0xffBDBDBD);
  static const Color grayColor3 = Color(0xff9A9A9A);
  static const Color primaryColorLite = Color(0xffF3F0FB);
  static const Color orangeColor = Colors.orange;
  static const Color white = Color(0xffFEFDFF);

//* Font Size
  static const double xxxLargeTitleFontSize = 32;
  static const double xxLargeTitleFontSize = 32;
  static const double xLargeTitleFontSize = 24;
  static const double largeTitleFontSize = 20;
  static const double titleFontSize = 18;
  static const double primaryFontSize = 16;
  static const double smallFontSize = 14;
  static const double xSmallFontSize = 12;

//* Icons Size
  static const double iconSize1 = 40;
  static const double iconSize2 = 24;
  static const double iconSize3 = 16;
  static const double iconSize4 = 14;

  //* font family
  static String mainFontFamily = 'Cairo';

  //* Text Style
  static TextStyle normalTextStyle(
          {double fontSize = primaryFontSize, color = appStyle.white}) =>
      TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: mainFontFamily,
      );

  static TextStyle boldTextStyle(
          {double fontSize = primaryFontSize, color = Colors.black}) =>
      TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        fontFamily: mainFontFamily,
        color: color,
      );

  static TextStyle weeklyReportTextStyle() {
    return TextStyle(
      color: appStyle.grayColor,
      fontWeight: FontWeight.bold,
      fontSize: 12,
      fontFamily: mainFontFamily,
    );
  }
}
