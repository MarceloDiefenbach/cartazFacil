import 'package:uuid/uuid.dart';
import 'Model/LayerData.dart';
import 'Model/Line.dart';
export 'Model/Line.dart';

class CartazModel {
  String id;
  double proportion;
  String backgroundColor;
  List<Line> content;
  List<LayerData> layers;

  CartazModel({
    String? id,
    required this.proportion,
    required this.backgroundColor,
    List<Line>? content,
    List<LayerData>? layers,
  }) : id = id ?? const Uuid().v4(), content = content ?? [], layers = layers ?? [];
}