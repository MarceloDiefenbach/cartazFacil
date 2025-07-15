import 'dart:io';

import 'package:cartazrapido/AdMob/AdHelper.dart';
import 'package:cartazrapido/ManagerCartazes.dart';
import 'package:cartazrapido/routes_enum.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import '../Cartaz/CartazViewModal.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String price = "";
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();

    BannerAd(
      adUnitId: AdHelper.homeBanner,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  void openWebsite(String url) async {

  }

  @override
  Widget build(BuildContext context) {
    final managerCatazes = context.watch<ManageCartazes>();
    final cartazViewModal = context.watch<CartazViewModel>();

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
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 24),
                  Text(managerCatazes.listCartaz.length.toString()),
                  ElevatedButton(
                      child: Text("Montar um cartaz"),
                      onPressed: () {
                        final cartaz = managerCatazes.createNewCartaz();

                        if (cartaz != null)
                          cartazViewModal.initModel(cartaz);

                        Navigator.pushNamed(
                          context,
                          AppRoute.cartaz.path,
                        );
                      }),
                  SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                        "Nós também temos um aplicativo de montar encartes para redes sociais",
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(height: 32),
               ElevatedButton(child: Text("Ver aplicativo de encartes"), onPressed: () {
                 if (Platform.isAndroid) {
                   openWebsite(
                       "https://play.google.com/store/apps/details?id=com.marcelo.encarte_facil_2");
                 } else {
                   openWebsite(
                       "https://apps.apple.com/us/app/encarte-f%C3%A1cil/id6443417835");
                 }
               },),

                ],
              ),
            ),
            if (_bannerAd != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
