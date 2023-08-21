import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cartazfacil/Model/Encarte.dart';
import 'package:cartazfacil/Model/Product.dart';
import 'package:flutter/material.dart';

class Service extends ChangeNotifier {

  List<Encarte> _encartes = [];

  List<Encarte> get encartes => _encartes;

  List<Theme> _temas = [];

  List<Theme> get temas => _temas;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  bool hasMoreProducts = true;

  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> getProducts() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://gpt-treinador.herokuapp.com/api/items'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> items = json.decode(response.body);
        _products = items.map((item) => ProductModel(
          name: item['name'] ?? '', // Provide a default empty string if 'name' is null
          value: '',
          link: item['imageURL'] ?? '', // Provide a default empty string if 'imageURL' is null
        )).toList();

        notifyListeners();
      } else {
        print('Failed to load products. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

}

