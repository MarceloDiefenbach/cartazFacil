import 'package:cartazrapido/DesignSystem/DesingSystem.dart';
import 'package:flutter/material.dart';

class TextChangeOverlay extends StatefulWidget {
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
  State<TextChangeOverlay> createState() => _TextChangeOverlayState();
}

class _TextChangeOverlayState extends State<TextChangeOverlay> {
  late final TextEditingController controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialText);
    // Espera um frame antes de pedir o foco (senão o contexto ainda não está pronto)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleCancel() {
    FocusScope.of(context).unfocus();
    widget.onCancel();
  }

  void _handleConfirm() {
    FocusScope.of(context).unfocus();
    widget.onConfirm(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Expanded(child: Container(color: Colors.black38,)),
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: AppPadding.s8),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: screenSize.width * 0.9,
                height: screenSize.height * 0.3,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppBorderRadius.medium),
                ),
                padding: const EdgeInsets.all(AppPadding.s4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        focusNode: _focusNode,
                        maxLines: null,
                        expands: true,
                        textAlign: TextAlign.left,
                        textAlignVertical: TextAlignVertical.top,
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
                          child: AppButton(text: "Cancelar", onPressed: _handleCancel),
                        ),
                        const SizedBox(width: AppPadding.s4),
                        Expanded(
                          child: AppButton(text: "Salvar", onPressed: _handleConfirm),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}