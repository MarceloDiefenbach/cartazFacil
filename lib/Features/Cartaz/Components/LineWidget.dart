import 'package:flutter/material.dart';
import '../Model/Line.dart';

class LineWidget extends StatelessWidget {
  final Line line;
  final bool isSelected;

  const LineWidget({
    Key? key,
    required this.line,
    required this.isSelected, // valor padrão
  }) : super(key: key);

  TextAlign _getTextAlign(Alignment alignment) {
    if (alignment == Alignment.centerLeft) {
      return TextAlign.left;
    } else if (alignment == Alignment.centerRight) {
      return TextAlign.right;
    } else {
      return TextAlign.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: isSelected ? Colors.white60 : Colors.transparent,
      child: Align(
        alignment: line.align,
        child: Padding(
          padding: line.paddingAsEdgeInsets,
          child: Text(
            line.text,
            textAlign: _getTextAlign(line.align),
            style: TextStyle(
              color: line.colorAsColor,
              fontSize: line.size,
              fontWeight: line.weight,

            ),
          ),
        ),
      ),
    );
  }
}