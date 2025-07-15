import 'dart:ui';

import 'package:cartazrapido/Features/Cartaz/Components/Background/PatternBackground.dart';
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
  })  : id = id ?? const Uuid().v4(),
        content = content ?? [
          Line(text: "OFERTA", color: "000000", size: 70.0, weight: FontWeight.w900, padding: [0,20,0,20]),
          Line(text: "PRODUTO", color: "000000", size: 25.0),
          Line(text: "De: R\$ 10,40", color: "000000", size: 17.0),
          Line(text: "Por: R\$ 3,99", color: "000000", size: 40.0, weight: FontWeight.w900),
        ],
        layers = layers ??
            [
              LayerData(
                  color: 'FF0000',
                  heightFraction: 0.3,
                  pattern: PatternBackgroundType.zigzag),
              LayerData(
                  color: '00FF00',
                  heightFraction: 0.3,
                  pattern: PatternBackgroundType.zigzag),
              LayerData(
                  color: '0000FF',
                  heightFraction: 0.3,
                  pattern: PatternBackgroundType.solid)
            ];

  factory CartazModel.fromJson(Map<String, dynamic> json) => CartazModel(
    id: json['id'],
    proportion: json['proportion'],
    backgroundColor: json['backgroundColor'],
    content: (json['content'] as List).map((e) => Line.fromJson(e)).toList(),
    layers: (json['layers'] as List).map((e) => LayerData.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'proportion': proportion,
    'backgroundColor': backgroundColor,
    'content': content.map((e) => e.toJson()).toList(),
    'layers': layers.map((e) => e.toJson()).toList(),
  };

}
