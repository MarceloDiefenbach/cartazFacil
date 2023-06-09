import 'package:cartazfacil/Features/AllProductsList.dart';
import 'package:cartazfacil/Features/Cartaz/CartazView.dart';
import 'package:cartazfacil/Features/Home.dart';
import 'package:cartazfacil/Initial/SplashScreen.dart';
import 'package:cartazfacil/Model/Product.dart';
import 'package:cartazfacil/Service.dart';
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
        ChangeNotifierProvider<Service>(
          create: (_) => Service(),
        ),
      ],
      child: MaterialApp(
        title: 'Cartaz Fácil',
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashScreen(),
          '/': (context) => HomeView(),
          '/list': (context) => AllProductsList(),
          '/cartaz': (context) {
            final product = ModalRoute.of(context)?.settings.arguments as Product;
            return CartazView(product);
          },
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}