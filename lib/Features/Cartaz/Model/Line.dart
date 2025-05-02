import 'package:flutter/material.dart';

class Line {
  String text;
  String color;
  double size;
  Alignment align;
  FontWeight weight;

  Line({
    required this.text,
    required this.color,
    required this.size,
    this.align = Alignment.center,
    this.weight = FontWeight.normal,
  });

  Color get colorAsColor {
    final hex = color.replaceAll('#', '');
    return Color(int.parse('0xFF$hex'));
  }
}