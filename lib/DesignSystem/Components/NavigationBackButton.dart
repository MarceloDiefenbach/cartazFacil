import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationBackButton extends StatefulWidget {
  @override
  _NavigationBackButtonState createState() => _NavigationBackButtonState();
}

class _NavigationBackButtonState extends State<NavigationBackButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoNavigationBarBackButton(
        color: Colors.black,
        previousPageTitle: "Voltar",
      ),
    );
  }
}
