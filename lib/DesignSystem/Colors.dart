import 'package:flutter/material.dart';

class LightColors {
  static const Color background = Colors.white;
  static const Color primary = Colors.black;
  static const Color alert = Colors.red;
  static const Color navigatorBar = Colors.transparent;

  static const Color text = Colors.black;
  static const Color textInvert = Colors.white;

  static const Color stroke = Colors.black;

  static const Color backgroundToolbar = Colors.white;
  static const Color buttonToolbar = Color.fromRGBO(240, 240, 240, 1.0);
}

class DarkColors {
  static const Color background = Colors.black;
  static const Color primary = Colors.white;
  static const Color alert = Colors.red;
  static const Color navigatorBar = Colors.transparent;

  static const Color text = Colors.black;
  static const Color textInvert = Colors.white;

  static const Color stroke = Colors.white;

  static const Color backgroundToolbar = Colors.grey;
  static const Color buttonToolbar = Colors.grey;
}

class AppColors {
  static bool isDarkMode = false;

  static Color background = isDarkMode ? DarkColors.background : LightColors.background;
  static Color primary = isDarkMode ? DarkColors.primary : LightColors.primary;
  static Color alert = isDarkMode ? DarkColors.alert : LightColors.alert;
  static Color navigatorBar = isDarkMode ? DarkColors.navigatorBar : LightColors.navigatorBar;

  static Color text = isDarkMode ? DarkColors.text : LightColors.text;
  static Color textInvert = isDarkMode ? DarkColors.textInvert : LightColors.textInvert;

  static Color stroke = isDarkMode ? DarkColors.stroke : LightColors.stroke;

  static Color backgroundToolbar = isDarkMode ? DarkColors.backgroundToolbar : LightColors.backgroundToolbar;
  static Color buttonToolbar = isDarkMode ? DarkColors.buttonToolbar : LightColors.buttonToolbar;
}