import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cartazrapido/AdMob/AdHelper.dart';
import 'package:cartazrapido/DesignSystem/Components/HorizontalToolbar.dart';
import 'package:cartazrapido/DesignSystem/DesingSystem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';

import '../../Model/CartazModel.dart';
import 'CartazViewModal.dart';

class CartazView extends StatelessWidget {
  final CartazModel cartaz;

  const CartazView({required this.cartaz, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartazViewModel(cartaz),
      child: const _CartazContent(),
    );
  }
}

class _CartazContent extends StatefulWidget {
  const _CartazContent({Key? key}) : super(key: key);

  @override
  State<_CartazContent> createState() => _CartazContentState();
}

class _CartazContentState extends State<_CartazContent> {
  final GlobalKey _containerKey = GlobalKey();
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  void _loadBanner() {
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

  Future<void> saveImageAndShowDialog(BuildContext context, Uint8List screenshot) async {
    final result = await ImageGallerySaver.saveImage(screenshot);
    if (result['isSuccess']) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text("Encarte salvo na galeria"),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("Ok"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    } else {
      print('Falha ao salvar: ${result['errorMessage']}');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CartazViewModel>();
    double width = MediaQuery.of(context).size.width;
    double cartazWidth = width * 0.9;
    double cartazHeight = cartazWidth * 1.415;

    return Material(
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const Spacer(),
                const Spacer(),

                GestureDetector(
                  onTap: viewModel.toggleToolbar,
                  child: RepaintBoundary(
                    key: _containerKey,
                    child: Container(
                      width: cartazWidth,
                      height: cartazHeight,
                      color: viewModel.backgroundColor,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Text(
                                viewModel.title,
                                style: AppFonts.largeTitle(weight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                AnimatedSlide(
                  offset: !viewModel.showToolbar ? const Offset(0, 0) : const Offset(0, 1),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Horizontaltoolbar(),
                  ),
                ),

                if (_bannerAd != null)
                  Container(
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
              ],
            ),
          ),

          AnimatedSlide(
            offset: viewModel.showToolbar ? const Offset(0, 0) : const Offset(1, 0),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Align(
              alignment: Alignment.centerRight,
              child: VerticalToolbar(),
            ),
          ),


        ],
      ),
    );
  }
}
