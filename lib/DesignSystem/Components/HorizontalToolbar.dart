import 'package:flutter/material.dart';
import '../DesingSystem.dart';

class Horizontaltoolbar extends StatelessWidget {
  final List<Widget> buttons;

  const Horizontaltoolbar({
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
          topRight: Radius.circular(AppBorderRadius.medium),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40), // sombra leve
            blurRadius: 30,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.s3,
            right: AppPadding.s3,
            bottom: AppPadding.s5,
            top: AppPadding.s3),
        child:  Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            buttons.length * 2 - 1,
                (index) => index.isEven
                ? buttons[index ~/ 2]
                : const SizedBox(width: AppPadding.s3), // seu espaçamento aqui
          ),
        ),
      ),
    );
  }
}