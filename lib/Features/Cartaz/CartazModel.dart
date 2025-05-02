import 'package:uuid/uuid.dart';
import 'Model/Line.dart';
export 'Model/Line.dart';

class CartazModel {
  String id;
  Line title;
  double proportion;
  String backgroundColor;
  List<Line> content;

  CartazModel({
    String? id,
    required this.title,
    required this.proportion,
    required this.backgroundColor,
    List<Line>? content,
  }) : id = id ?? const Uuid().v4(), content = content ?? [];
}