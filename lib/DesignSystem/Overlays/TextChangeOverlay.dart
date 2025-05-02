import 'package:cartazrapido/DesignSystem/DesingSystem.dart';
import 'package:flutter/material.dart';

class TextChangeOverlay extends StatelessWidget {
  final String initialText;
  final void Function(String text) onConfirm;
  final VoidCallback onCancel;

  const TextChangeOverlay({
    super.key,
    required this.initialText,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final TextEditingController controller = TextEditingController(text: initialText);

    return Stack(
      children: [
        Positioned.fill(child: Container(color: Colors.black87)),
        Center(
          child: Container(
            width: screenSize.width * 0.9,
            height: screenSize.height * 0.5,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppBorderRadius.medium),
            ),
            padding: const EdgeInsets.all(AppPadding.s4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.left,
                    style: AppFonts.title2(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppBorderRadius.small),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppPadding.s4),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(text: "Cancelar", onPressed: onCancel),
                    ),
                    const SizedBox(width: AppPadding.s4),
                    Expanded(
                      child: AppButton(
                        text: "Salvar",
                        onPressed: () {
                          onConfirm(controller.text);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}