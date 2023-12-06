import 'dart:typed_data';

import 'package:cartazrapido/AdMob/AdHelper.dart';
import 'package:cartazrapido/DesignSystem/Components/CFButton.dart';
import 'package:cartazrapido/DesignSystem/Tokens/Font.dart';
import 'package:cartazrapido/Model/Product.dart';
import 'package:cartazrapido/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:ui' as ui;

class CartazView extends StatefulWidget {
  ProductModel product;

  CartazView(this.product);

  @override
  _CartazViewState createState() => _CartazViewState();
}

class _CartazViewState extends State<CartazView> {

  String price = "";

  BannerAd? _bannerAd;

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productViewModel = Provider.of<Service>(context, listen: false);
      if (!productViewModel.isLoaded) {
        productViewModel.getProducts();
      }
    });

    BannerAd(
      adUnitId: AdHelper.encarteBanner,
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

  saveImageAndShowDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("Encarte salvo na galeria"),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  GlobalKey _containerKey = GlobalKey();

  Future<Uint8List> captureScreenshot() async {
    try {
      RenderRepaintBoundary boundary = _containerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 5);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      return pngBytes!;
    } catch (e) {
      print('Error capturing screenshot: $e');
      return Uint8List(0);
    }
  }

  Future<void> saveScreenshot(Uint8List screenshot) async {
    final result = await ImageGallerySaver.saveImage(screenshot);
    if (result['isSuccess']) {
      print('Screenshot saved successfully!');
      saveImageAndShowDialog();
    } else {
      print('Failed to save screenshot: ${result['errorMessage']}');
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
                  if (_bannerAd != null)
                    Container(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    ),
                  RepaintBoundary(
                    key: _containerKey,
                    child: Container(
                      width: cartazWidth,
                      height: cartazHeight,
                      color: Color(0xFFFEF100),
                      child: Stack(
                        children: [
                          Image.asset('lib/assets/BGofertas.png'),
                          Column(
                            children: [
                              SizedBox(height: cartazHeight*0.34),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                                child: Text(
                                  widget.product.name,
                                  style: Fonts.cartazProductName,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("R\$", style: Fonts.cartazMoneySymbol),
                                  SizedBox(width: cartazWidth * 0.02),
                                  Text(
                                    widget.product.value,
                                    style: Fonts.cartazPrice,
                                  ),
                                ],
                              ),
                              Spacer(),
                              Spacer(),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Screenshot(
                  //   controller: screenshotController,
                  //   child: Container(
                  //     width: cartazWidth,
                  //     height: cartazHeight,
                  //     color: Color(0xFFFEF100),
                  //     child: Stack(
                  //       children: [
                  //         Image.asset('lib/assets/BGofertas.png'),
                  //         Column(
                  //           children: [
                  //             SizedBox(height: cartazHeight*0.34),
                  //
                  //             Padding(
                  //               padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  //               child: Text(
                  //                 widget.product.name,
                  //                 style: Fonts.cartazProductName,
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             ),
                  //             Spacer(),
                  //             Row(
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Text("R\$", style: Fonts.cartazMoneySymbol),
                  //                 SizedBox(width: cartazWidth * 0.02),
                  //                 Text(
                  //                   widget.product.valor,
                  //                   style: Fonts.cartazPrice,
                  //                 ),
                  //               ],
                  //             ),
                  //             Spacer(),
                  //             Spacer(),
                  //             Spacer(),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    child: CFButton("Salvar na galeria"),
                    onTap: (){
                      // screenshotController
                      //     .capture(delay: Duration(seconds: 1))
                      //     .then((capturedImage) async {
                      //   ImageGallerySaver.saveImage(capturedImage!);
                      // }).catchError((onError) {
                      //   print(onError);
                      // });
                      captureScreenshot().then((screenshot) {
                        saveScreenshot(screenshot);
                      });
                    },
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    child: CFButton("Montar outro cartaz"),
                    onTap: (){
                      Navigator.pop(context);
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
