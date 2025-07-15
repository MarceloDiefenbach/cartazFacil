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

  factory LayerData.fromJson(Map<String, dynamic> json) => LayerData(
    color: json['color'],
    heightFraction: json['heightFraction'].toDouble(),
    pattern: PatternBackgroundType.values[json['pattern']],
  );

  Map<String, dynamic> toJson() => {
    'color': color,
    'heightFraction': heightFraction,
    'pattern': pattern.index,
  };

  Color get colorAsColor {
    final hex = color.replaceAll('#', '');
    return Color(int.parse('0xFF$hex'));
  }
}