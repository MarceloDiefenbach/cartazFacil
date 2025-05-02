import 'package:uuid/uuid.dart';

class CartazModel {
  final String id;
  final String title;
  final String hexColor;

  CartazModel({
    String? id,
    required this.title,
    required this.hexColor,
  }) : id = id ?? const Uuid().v4();
}