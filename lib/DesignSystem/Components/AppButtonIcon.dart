import 'package:flutter/material.dart';
import 'package:cartazrapido/DesignSystem/DesingSystem.dart';

class AppButtonIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final bool hasBackground;
  final bool disable;


  const AppButtonIcon({
    super.key,
    required this.icon,
    required this.onPressed,
    this.disable = false,
    this.color,
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
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color ?? AppColors.text.withAlpha(disable ? 100 : 255), // usa valor customizado ou padrão
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}