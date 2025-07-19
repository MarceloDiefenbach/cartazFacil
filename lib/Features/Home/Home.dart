import 'package:cartazrapido/AdMob/AdHelper.dart';
import 'package:cartazrapido/Features/Home/Components/CartazMini.dart';
import 'package:cartazrapido/ManagerCartazes.dart';
import 'package:cartazrapido/Utils/ListWidgetExtentions.dart';
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

  void openWebsite(String url) async {}

  @override
  Widget build(BuildContext context) {
    final managerCatazes = context.watch<ManageCartazes>();
    final cartazViewModal = context.watch<CartazViewModel>();
    final spacingElement = 12.0;

    return Material(
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: LayoutBuilder(builder: (context, constrains) {
                  final width =
                      (constrains.maxWidth - (spacingElement * 2)) / 3;
                  return Column(children: [
                    ...managerCatazes.listCartaz
                        .split(3)
                        .map((pair) {
                          return Row(
                            children: pair
                                .map((cartaz) => CartazMini(
                                    width: width,
                                    cartaz: cartaz,
                                    onTap: () {
                                      managerCatazes.selectCartaz(cartaz);
                                      cartazViewModal.initModel(managerCatazes.selectedCartaz!);

                                      Navigator.pushNamed(
                                        context,
                                        AppRoute.cartaz.path,
                                      );
                                    }))
                                .toList()
                                .withHorizontalSpacing(width: 12),
                          );
                        })
                        .toList()
                        .withVerticalSpacing(height: 16),
                  ]);
                }),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  child: Text("Criar novo cartaz"),
                  onPressed: () {
                    final cartaz = managerCatazes.createNewCartaz();

                    if (cartaz != null) cartazViewModal.initModel(cartaz);

                    Navigator.pushNamed(
                      context,
                      AppRoute.cartaz.path,
                    );
                  }),
            ),

            // if (_bannerAd != null)
            //   Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Container(
            //       width: _bannerAd!.size.width.toDouble(),
            //       height: _bannerAd!.size.height.toDouble(),
            //       child: AdWidget(ad: _bannerAd!),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
