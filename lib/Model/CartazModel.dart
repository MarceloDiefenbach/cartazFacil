import 'dart:ui';

class CartazModel {
  final String title;
  final String hexColor;

  CartazModel({
    required this.title,
    required this.hexColor,
  });

  /// Converte a cor em string (#RRGGBB ou #AARRGGBB) para um objeto Color
  Color get color {
    String hex = hexColor.replaceAll('#', '');

    if (hex.length == 6) {
      hex = 'FF$hex'; // Adiciona opacidade total se não existir
    }

    return Color(int.parse('0x$hex'));
  }
}