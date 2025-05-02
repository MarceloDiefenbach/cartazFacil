import 'package:flutter/material.dart';
import 'package:cartazrapido/DesignSystem/DesingSystem.dart';

class AppButtonIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSelected;

  const AppButtonIcon({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(AppPadding.s4),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.selectedToolbar : Colors.transparent,
            borderRadius: BorderRadius.circular(AppBorderRadius.medium)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
            color: AppColors.text)
          ],
        ),
      ),
    );
  }
}