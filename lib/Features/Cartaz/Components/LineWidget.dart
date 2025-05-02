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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: isSelected ? Colors.red : Colors.transparent,
      child: Align(
        alignment: line.align,
        child: Text(
          line.text,
          style: TextStyle(
            color: line.colorAsColor,
            fontSize: line.size,
            fontWeight: line.weight,
          ),
        ),
      ),
    );
  }
}