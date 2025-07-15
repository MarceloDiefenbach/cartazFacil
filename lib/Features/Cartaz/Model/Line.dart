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
    this.padding = const [0.0, 0.0, 0.0, 0.0]
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

    final horizontalTotal = left + right;
    final verticalTotal = top + bottom;

    double resolveLeft = 0;
    double resolveRight = 0;
    double resolveTop = 0;
    double resolveBottom = 0;

    // Horizontal (x)
    if (align.x <= -0.5) {
      // Alinhado à esquerda → tudo no left
      resolveLeft = horizontalTotal;
      resolveRight = 0;
    } else if (align.x >= 0.5) {
      // Alinhado à direita → tudo no right
      resolveLeft = 0;
      resolveRight = horizontalTotal;
    } else {
      // Centralizado → divide igualmente
      resolveLeft = horizontalTotal / 2;
      resolveRight = horizontalTotal / 2;
    }

    // Vertical (y)
    if (align.y <= -0.5) {
      // Alinhado no topo → tudo no top
      resolveTop = verticalTotal;
      resolveBottom = 0;
    } else if (align.y >= 0.5) {
      // Alinhado na base → tudo no bottom
      resolveTop = 0;
      resolveBottom = verticalTotal;
    } else {
      // Centralizado → divide igualmente
      resolveTop = verticalTotal / 2;
      resolveBottom = verticalTotal / 2;
    }

    return EdgeInsets.fromLTRB(
      resolveLeft,
      resolveTop,
      resolveRight,
      resolveBottom,
    );
  }

  void setPaddingValue(List<IndexPaddings> sides, double value) {
    final updatedPadding = List<double>.from(padding);
    for (final side in sides) {
      updatedPadding[side.number] = value;
    }
    padding = updatedPadding;
  }
}