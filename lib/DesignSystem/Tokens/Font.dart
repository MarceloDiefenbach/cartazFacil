import 'package:flutter/material.dart';

class Fonts {
  static TextStyle bigRegular({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 40, fontWeight: FontWeight.normal, color: color);
  static TextStyle bigBold({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 40, fontWeight: FontWeight.bold, color: color);
  static TextStyle largeTitleBlack({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 32, fontWeight: FontWeight.w900, color: color);
  static TextStyle largeTitleBold({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 32, fontWeight: FontWeight.bold, color: color);
  static TextStyle largeTitleRegular({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 32, fontWeight: FontWeight.normal, color: color);
  static TextStyle titleBold({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 24, fontWeight: FontWeight.bold, color: color);
  static TextStyle titleRegular({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 24, fontWeight: FontWeight.normal, color: color);
  static TextStyle normalBold({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 16, fontWeight: FontWeight.bold, color: color);
  static TextStyle normalExtraBold({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 16, fontWeight: FontWeight.w800, color: color);
  static TextStyle normalSemiBold({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 16, fontWeight: FontWeight.w600, color: color);
  static TextStyle normalRegular({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 16, fontWeight: FontWeight.normal, color: color);
  static TextStyle smallBold({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.bold, color: color);
  static TextStyle smallRegular({Color color = Colors.black}) => TextStyle(fontFamily: "Inter", fontSize: 12, fontWeight: FontWeight.normal, color: color);
  static const TextStyle cartazTitle = TextStyle(fontFamily: "Impact", fontSize: 88, fontWeight: FontWeight.bold, color: Color(0xFFFEF100));
  static const TextStyle cartazProductName = TextStyle(fontFamily: "Impact", fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle cartazPrice = TextStyle(fontFamily: "Impact", fontSize: 130, fontWeight: FontWeight.bold, color: Colors.red);
  static const TextStyle cartazMoneySymbol = TextStyle(fontFamily: "Impact", fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
}