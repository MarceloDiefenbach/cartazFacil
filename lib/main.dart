import 'package:cartazrapido/Features/Cartaz/CartazView.dart';
import 'package:cartazrapido/Features/Home.dart';
import 'package:cartazrapido/Initial/SplashScreen.dart';
import 'package:cartazrapido/Model/CartazModel.dart';
import 'package:cartazrapido/Service.dart';
import 'package:cartazrapido/routes_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ManagerEncarte>(
          create: (_) => ManagerEncarte(),
        ),
      ],
      child: MaterialApp(
        title: 'Cartaz Rápido',
        initialRoute: AppRoute.splash.path,
        routes: {
          AppRoute.splash.path: (context) => SplashScreen(),
          AppRoute.home.path: (context) => HomeView(),
          AppRoute.cartaz.path: (context) => CartazView(cartaz: CartazModel(title: "TESTE", hexColor: "#FF0000"),),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}