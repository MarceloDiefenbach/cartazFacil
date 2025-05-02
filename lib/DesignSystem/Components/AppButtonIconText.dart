import 'package:flutter/material.dart';
import 'package:cartazrapido/DesignSystem/DesingSystem.dart';

class AppButtonIconText extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool hasBackground;

  const AppButtonIconText({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.hasBackground = true
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: hasBackground ? AppColors.buttonToolbar : Colors.transparent,
          borderRadius: BorderRadius.circular(AppBorderRadius.medium),
          border: isSelected
              ? Border.all(color: Colors.black, width: 2)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: AppFonts.headline(weight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}