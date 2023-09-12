import 'package:cartazfacil/Model/Product.dart';

class Encarte {
  final String name;
  String validade;
  List<ProductModel> produtos;
  final String tema;
  final String topo;
  String textColor;
  String priceBGColor;
  String priceTextColor;

  Encarte({
    required this.name,
    required this.validade,
    required this.produtos,
    required this.tema,
    required this.topo,
    required this.textColor,
    required this.priceBGColor,
    required this.priceTextColor
  });

  factory Encarte.fromJson(Map<String, dynamic> json) {
    var productList = json['produtos'] as List;
    List<ProductModel> products = productList.map((i) => ProductModel.fromJson(i)).toList();

    return Encarte(
      name: json['name'] as String,
      validade: json['validade'] as String,
      produtos: products,
      tema: json['tema'] as String,
      topo: json['topo'] as String,
      textColor: json['textColor'] as String,
      priceBGColor: json['priceBGColor'] as String,
      priceTextColor: json['priceTextColor'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'validade': validade,
    'produtos': produtos.map((e) => e.toJson()).toList(),
    'tema': tema,
    'topo': topo,
    'textColor': textColor,
    'priceBGColor': priceBGColor,
    'priceTextColor': priceTextColor,
  };

  void reorderProducts(List<ProductModel> reorderedProducts) {
    produtos.clear();
    produtos.addAll(reorderedProducts);
  }
}
