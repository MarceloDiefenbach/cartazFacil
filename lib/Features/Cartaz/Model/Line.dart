import 'package:flutter/material.dart';


enum IndexPaddings {
  left(0),
  top(1),
  right(2),
  bottom(3);

  final int number;
  const IndexPaddings(this.number);
}

class Line {
  String text;
  String color;
  double size;
  Alignment align;
  FontWeight weight;
  List<double> padding;

  Line({
    required this.text,
    required this.color,
    required this.size,
    this.align = Alignment.center,
    this.weight = FontWeight.normal,
    this.padding = const [0.0, 0.0, 0.0, 0.0],
  });

  Color get colorAsColor {
    final hex = color.replaceAll('#', '');
    return Color(int.parse('0xFF$hex'));
  }

  EdgeInsets get paddingAsEdgeInsets {
    final left = padding[IndexPaddings.left.number];
    final top = padding[IndexPaddings.top.number];
    final right = padding[IndexPaddings.right.number];
    final bottom = padding[IndexPaddings.bottom.number];
    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  /// ✅ Serialização
  factory Line.fromJson(Map<String, dynamic> json) => Line(
    text: json['text'],
    color: json['color'],
    size: json['size'].toDouble(),
    align: _alignmentFromJson(json['align']),
    weight: _fontWeightFromJson(json['weight']),
    padding: List<double>.from(json['padding'].map((e) => e.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'color': color,
    'size': size,
    'align': _alignmentToJson(align),
    'weight': _fontWeightToJson(weight),
    'padding': padding,
  };

  // 🔁 Helpers para Alignment e FontWeight
  static String _alignmentToJson(Alignment align) {
    if (align == Alignment.centerLeft) return 'centerLeft';
    if (align == Alignment.centerRight) return 'centerRight';
    if (align == Alignment.topCenter) return 'topCenter';
    if (align == Alignment.bottomCenter) return 'bottomCenter';
    return 'center'; // padrão
  }

  void setPaddingValue(List<IndexPaddings> sides, double value) {
    if (padding.length != 4) {
      padding = List.filled(4, 0.0);
    }
    final updated = List<double>.from(padding);
    for (final side in sides) {
      updated[side.number] = value;
    }
    padding = updated;
  }

  static Alignment _alignmentFromJson(String value) {
    switch (value) {
      case 'centerLeft':
        return Alignment.centerLeft;
      case 'centerRight':
        return Alignment.centerRight;
      case 'topCenter':
        return Alignment.topCenter;
      case 'bottomCenter':
        return Alignment.bottomCenter;
      default:
        return Alignment.center;
    }
  }

  static int _fontWeightToJson(FontWeight weight) => weight.index;

  static FontWeight _fontWeightFromJson(int index) => FontWeight.values[index];
}