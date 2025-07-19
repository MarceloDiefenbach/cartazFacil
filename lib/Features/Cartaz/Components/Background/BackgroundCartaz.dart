import 'package:flutter/material.dart';
import '../../Model/LayerData.dart';
import 'PatternBackground.dart';
import 'package:cartazrapido/DesignSystem/Colors.dart';

class BackgroundCartaz extends StatefulWidget {
  final List<LayerData> layers;
  final double width;
  final double height;
  final bool showLines;
  final int? selectedLayer;
  final void Function(List<double> values)? onConfirm;
  final void Function(int? index)? onSelectedLayer;

  const BackgroundCartaz({
    super.key,
    required this.layers,
    required this.width,
    required this.height,
    this.showLines = false,
    this.selectedLayer,
    this.onConfirm,
    this.onSelectedLayer,
  });

  @override
  State<BackgroundCartaz> createState() => _BackgroundCartazState();
}

class _BackgroundCartazState extends State<BackgroundCartaz> {
  late List<double> dragPositions;
  double heightLine = 4.0;
  double heightChevron = 20.0;


  @override
  void initState() {
    super.initState();
    final numDividers = widget.layers.length - 1;

    dragPositions = List.generate(
      numDividers, (i) => (i + 1) / widget.layers.length,
    );
  }

  double offsetCalc() {
    return (heightLine + (2 * heightChevron)) / 2;
  }

  List<Widget> buildLayers(double totalHeight) {
    final List<double> heights = [];
    double previous = 0.0;

    for (int i = 0; i <= dragPositions.length; i++) {
      final current = (i < dragPositions.length) ? dragPositions[i] : 1.0;
      heights.add(current - previous);
      previous = current;
    }

    return List.generate(widget.layers.length, (i) {
      final layer = widget.layers[i];
      final nextLayer = (i + 1 < widget.layers.length) ? widget.layers[i + 1] : widget.layers[i];

      // return GestureDetector(
      //   onTap: () {
      //     if (widget.showLines) {
      //         widget.onSelectedLayer?.call(i);
      //     }
      //   },
      //   child:
        return PatternBackground(
          color: layer.colorAsColor,
          background: nextLayer.colorAsColor,
          height: totalHeight * heights[i],
          pattern: layer.pattern,
          isSelected: (widget.selectedLayer == i),
        );
      // );

    });
  }

  List<Widget> buildLines(double totalHeight) {
    return List.generate(dragPositions.length, (i) {
      return Positioned(
        top: totalHeight * dragPositions[i] - offsetCalc(),
        left: 0,
        right: 0,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              dragPositions[i] += details.delta.dy / totalHeight;

              final min = i == 0 ? 0.0 : dragPositions[i - 1] + 0.05;
              final max = i == dragPositions.length - 1 ? 1.0 : dragPositions[i + 1] - 0.05;

              dragPositions[i] = dragPositions[i].clamp(min, max);
              widget.onConfirm?.call(dragPositions);
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.keyboard_arrow_up,
                color: AppColors.text,
                size: heightChevron,
              ),
              Container(
                height: heightLine,
                color: Colors.black,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.text,
                size: heightChevron,
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = widget.height;

    return SizedBox(
      width: widget.width,
      height: totalHeight,
      child: Stack(
        children: [
          Column(
            children: buildLayers(totalHeight),
          ),
          if (widget.showLines) ...buildLines(totalHeight),
        ],
      ),
    );
  }
}