import 'package:cartazrapido/DesignSystem/DesignTokens.dart';
import 'package:cartazrapido/DesignSystem/Tokens/Font.dart';
import 'package:flutter/material.dart';

class CFButton extends StatefulWidget {

  String title;

  CFButton(this.title);

  @override
  _CFButtonState createState() => _CFButtonState();
}

class _CFButtonState extends State<CFButton> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
        height: 50,
        width: width*0.9,
        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium(),
          color: colorBrandPrimary(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.title}', style: Fonts.normalBold(color: Colors.white)),
          ],
        )
    );
  }
}