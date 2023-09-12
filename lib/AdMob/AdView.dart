import 'package:flutter/material.dart';

class AdView extends StatelessWidget {
  const AdView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.13,
      color: Colors.grey,
      child: Column(children: [
        Spacer(),
        Text("Ads", textAlign: TextAlign.center),
        Spacer(),
      ]),
    );
  }
}
