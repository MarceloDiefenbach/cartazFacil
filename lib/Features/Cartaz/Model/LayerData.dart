import 'dart:ui';

import '../Components/Background/PatternBackground.dart';

class LayerData {
  String color;
  double heightFraction;
  PatternBackgroundType pattern;

  LayerData({
    required this.color,
    required this.heightFraction,
    required this.pattern,
  });

  Color get colorAsColor {
    final hex = color.replaceAll('#', '');
    return Color(int.parse('0xFF$hex'));
  }
}