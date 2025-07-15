import 'package:flutter/material.dart';

enum PatternBackgroundType {
  solid('lib/assets/solid.png'),
  circular('lib/assets/circular.png'),
  wave('lib/assets/wave.png'),
  zigzag('lib/assets/zigzag.png'),
  triangular('lib/assets/triangular.png'),
  triangularcurved('lib/assets/triagularcurved.png');

  final String assetName;
  const PatternBackgroundType(this.assetName);
}

class PatternBackground extends StatelessWidget {
  final double height;
  final Color color;
  final Color background;
  final PatternBackgroundType pattern;
  final bool isSelected;

  const PatternBackground({
    Key? key,
    required this.height,
    required this.color,
    required this.background,
    required this.pattern,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content;

    content = Container(
      width: double.infinity,
      height: height,
      color: background,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: color,
            ),
          ),
          if ((pattern != PatternBackgroundType.solid))
            Transform.translate(
            offset: const Offset(0, -1), // move 1px para cima
            child: Image.asset(
              pattern.assetName,
              color: color,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );

    return Stack(
      children: [
        content,
        if (isSelected)
          Container(
            height: height,
            color: Colors.white.withAlpha(100),
          ),
      ],
    );
  }
}
