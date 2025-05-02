import 'package:flutter/material.dart';
import '../DesingSystem.dart';

class Horizontaltoolbar extends StatelessWidget {
  const Horizontaltoolbar({
    Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundToolbar,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppBorderRadius.medium),
          topRight: Radius.circular(AppBorderRadius.medium),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100), // sombra leve
            blurRadius: 30,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButtonIcon(icon: Icons.ice_skating, onPressed: () {

            }),
            AppButtonIcon(icon: Icons.face, onPressed: () {

            }),
            AppButtonIcon(icon: Icons.text_decrease, onPressed: () {

            }),
          ],
        ),
      ),
    );
  }
}