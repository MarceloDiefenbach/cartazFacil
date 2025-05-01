import 'package:flutter/material.dart';

class LightColors {
  static const Color background = Colors.white;
  static const Color primary = Colors.black;

  static const Color text = Colors.white;
  static const Color textInvert = Colors.black;
}

class DarkColors {
  static const Color background = Colors.black;
  static const Color primary = Colors.white;

  static const Color text = Colors.black;
  static const Color textInvert = Colors.white;
}

class AppColors {
  static bool isDarkMode = false;

  static Color background = isDarkMode ? DarkColors.background : LightColors.background;
  static Color primary = isDarkMode ? DarkColors.primary : LightColors.primary;

  static Color text = isDarkMode ? DarkColors.text : LightColors.text;
  static Color textInvert = isDarkMode ? DarkColors.textInvert : LightColors.textInvert;

}