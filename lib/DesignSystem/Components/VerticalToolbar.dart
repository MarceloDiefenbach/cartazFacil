import 'package:flutter/material.dart';
import '../DesingSystem.dart';

class VerticalToolbar extends StatelessWidget {
  final List<Widget> buttons;

  const VerticalToolbar({
    Key? key,
    required this.buttons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundToolbar,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppBorderRadius.medium),
          bottomLeft: Radius.circular(AppBorderRadius.medium),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 40,
            offset: Offset(-10, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.s3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            buttons.length * 2 - 1,
            (index) => index.isEven
                ? buttons[index ~/ 2]
                : const SizedBox(height: AppPadding.s3), // seu espaçamento aqui
          ),
        ),
      ),
    );
  }
}
