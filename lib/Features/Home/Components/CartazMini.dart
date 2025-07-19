import 'package:cartazrapido/Features/Cartaz/CartazModel.dart';
import 'package:flutter/material.dart';

import '../../Cartaz/Components/Background/BackgroundCartaz.dart';

class CartazMini extends StatelessWidget {
  final double width;
  final CartazModel cartaz;
  final VoidCallback? onTap;

  CartazMini({required this.width, required this.cartaz, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: BackgroundCartaz(
          layers: cartaz.layers,
          width: width,
          height: width,
        ),
    );
  }
}
