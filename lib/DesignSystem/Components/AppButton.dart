import 'package:flutter/material.dart';
import 'package:cartazrapido/DesignSystem/DesingSystem.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
        ),
        padding: const EdgeInsets.all(AppPadding.s4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppFonts.headline(),
            ),
          ],
        ),
      ),
    );
  }
}