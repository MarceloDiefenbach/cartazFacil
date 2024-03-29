import 'package:cartazrapido/Features/AllProductsList.dart';
import 'package:cartazrapido/Features/Cartaz/CartazView.dart';
import 'package:cartazrapido/Features/Home.dart';
import 'package:cartazrapido/Initial/SplashScreen.dart';
import 'package:cartazrapido/Model/Product.dart';
import 'package:cartazrapido/Service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

void main() {
  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Service>(
          create: (_) => Service(),
        ),
      ],
      child: MaterialApp(
        title: 'Cartaz Rápido',
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashScreen(),
          '/': (context) => HomeView(),
          '/list': (context) => AllProductsList(),
          '/cartaz': (context) {
            final product = ModalRoute.of(context)?.settings.arguments as ProductModel;
            return CartazView(product);
          },
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}