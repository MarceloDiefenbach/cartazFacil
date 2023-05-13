import 'dart:async';
import 'package:cartazfacil/DesignSystem/DesignTokens.dart';
import 'package:cartazfacil/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    Timer(Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {

    final productViewModel = Provider.of<Service>(context);
    productViewModel.getProducts();

    return Material(
      child: Container(
        color: colorBrandPrimary(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(
              color: Colors.white,
              animating: true,
              radius: 35,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text("Carregando\nsuas informações",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 20)
              ),
            )
          ],
        ),
      ),
    );
  }
}
