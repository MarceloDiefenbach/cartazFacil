// ViewModel
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cartazfacil/Model/Encarte.dart';
import 'package:cartazfacil/Model/Product.dart';
import 'package:flutter/material.dart';

// ViewModel
class Service extends ChangeNotifier {

  List<Product> _products = [];

  List<Product> get products => _products;

  List<Encarte> _encartes = [];

  List<Encarte> get encartes => _encartes;

  List<Theme> _temas = [];

  List<Theme> get temas => _temas;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  bool hasMoreProducts = true;

  Future<void> getProducts() async {

    http.Response response;
    http.Response response2;
    Map<String, dynamic> retorno;
    List records;
    late String offset;

    for (int i = 0; i < 15; i++) {
      if (i == 0){
        print("indice ${i}");
        response = await http.get(
          Uri.parse(
              'https://api.airtable.com/v0/app54l1CJQeskplHm/produtos'),
          headers: {'Authorization': 'Bearer patIQAD8GnjCo7FSe.5956bda0225781a8fc3a94e41f2d419a27b02cf7cb23bdf2b3f78ea7b590b94f'},
        );

        retorno = json.decode(response.body);
        records = retorno["records"];

        for (int i = 0; i < records.length; i++) {
          Product product = Product(
            name: records[i]["fields"]["primeira"],
            valor: "",
            link: records[i]["fields"]["imagem"],
            keywords: records[i]["fields"]["segunda"],
            barcode: '', owner: ''
          );
          _products.add(product);
        }

        offset = retorno["offset"];

      } else {
        if (hasMoreProducts) {
          response2 = await http.get(
            Uri.parse(
                "https://api.airtable.com/v0/app54l1CJQeskplHm/produtos?view=Grid%20view&offset=$offset"),
            headers: {
              'Authorization': 'Bearer patIQAD8GnjCo7FSe.5956bda0225781a8fc3a94e41f2d419a27b02cf7cb23bdf2b3f78ea7b590b94f'
            },
          );

          Map<String, dynamic> retorno2 = json.decode(response2.body);
          List records2 = retorno2["records"];

          if (retorno2["offset"] == offset) {
            hasMoreProducts = false;
          }

          for (int i = 0; i < records2.length; i++) {
            Product product = Product(name: records2[i]["fields"]["primeira"],
                valor: "",
                link: records2[i]["fields"]["imagem"],
                keywords: "",
                barcode: '', owner: ''
            );
            _products.add(product);
          }
          offset = retorno2["offset"];
        } else {
          //nothing to do here
        }
      }
    }
    notifyListeners();
  }

  Future<void> POSTUserOnSendPulse(String email, String name, String phone) async {
    final url = Uri.https('events.sendpulse.com', '/events/id/29e6ed2a05f741eae39eb6a22b47dc8c/8304397');
    final headers = {'Content-Type': 'application/json'};
    final data = {'email': email, 'phone': phone, 'name': name};
    final jsonBody = json.encode(data);

    final response = await http.post(url, headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      print('POST request succeeded');
    } else {
      print('POST request failed with status: ${response.statusCode}');
    }
  }


  Future<void> newOportunityOnSendPulse(String email, String name, String phone) async {

    final url = Uri.https('events.sendpulse.com', '/events/id/ee9b5483987a45ec80d9cf9e2c111ea1/8304397');
    final headers = {'Content-Type': 'application/json'};
    final data = {
      "email": email,
      "phone": phone,
      "name": name,
      "order_date": "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute}"
    };
    final jsonBody = json.encode(data);

    final response = await http.post(url, headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      print('POST request succeeded');
    } else {
      print('POST request failed with status: ${response.statusCode}');
    }
  }

}