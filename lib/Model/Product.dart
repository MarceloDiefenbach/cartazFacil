
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