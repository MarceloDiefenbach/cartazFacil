import 'package:cartazrapido/Features/Cartaz/CartazView.dart';
import 'package:cartazrapido/Features/Cartaz/CartazViewModal.dart';
import 'package:cartazrapido/Features/Home/Home.dart';
import 'package:cartazrapido/Initial/SplashScreen.dart';
import 'package:cartazrapido/ManagerCartazes.dart';
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
        ChangeNotifierProvider<ManageCartazes>(
          create: (_) {
            final vm = ManageCartazes();
            vm.initCartazes();
            return vm;
          },
        ),
        ChangeNotifierProvider<CartazViewModel>(
          create: (_) => CartazViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Cartaz Rápido',
        initialRoute: AppRoute.splash.path,
        routes: {
          AppRoute.splash.path: (context) => SplashScreen(),
          AppRoute.home.path: (context) => HomeView(),
          AppRoute.cartaz.path: (context) => CartazView(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}