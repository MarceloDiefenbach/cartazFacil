import 'package:cartazrapido/DesignSystem/DesingSystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerOverlay extends StatelessWidget {
  final Color initialColor;
  final void Function(String hexColor) onColorChanged;
  final VoidCallback onCancel;

  const ColorPickerOverlay({
    super.key,
    required this.initialColor,
    required this.onColorChanged,
    required this.onCancel,
  });

  String _toHex6(Color color) {
    return color.value
        .toRadixString(16)
        .padLeft(8, '0')
        .substring(2)
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Color colorChange = initialColor;

    return Stack(
      children: [
        Expanded(child: Container(color: Colors.black87)),
        Center(
          child: Container(
            width: screenSize.width * 0.9,
            height: screenSize.height * 0.7,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppBorderRadius.medium),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.s4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: AppPadding.s4,
                  ),
                  Text(
                    "Cor do fundo",
                    style: AppFonts.title1(weight: FontWeight.w600),
                  ),
                  Spacer(),
                  ColorPicker(
                    pickerColor: initialColor,
                    onColorChanged: (color) {
                      colorChange = color;
                    },
                    enableAlpha: false,
                    displayThumbColor: true,
                    paletteType: PaletteType.hueWheel,
                    labelTypes: const [],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(text: "Cancelar", onPressed: onCancel),
                      ),
                      SizedBox(
                        width: AppPadding.s4,
                      ),
                      Expanded(
                        child: AppButton(text: "Salvar", onPressed: () {
                          onColorChanged(_toHex6(colorChange));
                        }),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
