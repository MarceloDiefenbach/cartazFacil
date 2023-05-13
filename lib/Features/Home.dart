import 'dart:io';
import 'dart:typed_data';

import 'package:cartazfacil/DesignSystem/Components/CFButton.dart';
import 'package:cartazfacil/DesignSystem/Tokens/Font.dart';
import 'package:cartazfacil/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  String price = "";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productViewModel = Provider.of<Service>(context, listen: false);
      if (!productViewModel.isLoaded) {
        productViewModel.getProducts();
      }
    });
  }

  void openWebsite(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o site $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double cartazWidth = width * 0.9;
    double cartazHeight = cartazWidth * 1.415;

    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: Text("Monte cartazes para usar em seu supermercado",
                        textAlign: TextAlign.center,
                        style: Fonts.largeTitleBlack()),
                  ),
                  SizedBox(height: 24),
                  GestureDetector(
                    child: CFButton("Montar um cartaz"),
                    onTap: (){
                      Navigator.pushNamed(
                        context,
                        '/list',
                      );
                    },
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: Text("Nós também temos um aplicativo de montar encartes para redes sociais",
                      textAlign: TextAlign.center,
                      style: Fonts.normalRegular()),
                  ),
                  SizedBox(height: 32),
                  GestureDetector(
                    child: CFButton("Ver aplicativo de encartes"),
                    onTap: (){
                      if(Platform.isAndroid) {
                        openWebsite("https://play.google.com/store/apps/details?id=com.marcelo.encarte_facil_2");
                      } else {
                        openWebsite("https://apps.apple.com/us/app/encarte-f%C3%A1cil/id6443417835");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
