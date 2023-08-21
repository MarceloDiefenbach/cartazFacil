class Product {
  final String name;
  String valor;
  final String link;
  final String keywords;
  final String barcode;
  final String owner;

  Product({
    required this.name,
    required this.valor,
    required this.link,
    required this.keywords,
    required this.barcode,
    required this.owner,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['fields']['primeira'] as String,
      valor: json['fields']['valor'] as String,
      link: json['fields']['imagem'] as String,
      keywords: json['fields']['CATEGORIA'] as String,
      barcode: '',
      owner: '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'valor': valor,
    'link': link,
    'keywords': keywords,
    'barcode': barcode,
    'owner': owner,
  };
}

class ProductModel {
  final String name;
  String value;
  final String link;

  ProductModel({
    required this.name,
    required this.value,
    required this.link,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] as String,
      value: json['valor'] as String,
      link: json['link'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'valor': value,
    'link': link,
  };
}