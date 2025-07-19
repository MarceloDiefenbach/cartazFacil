import 'package:flutter/material.dart';
import 'CartazModel.dart';
import 'Components/Background/PatternBackground.dart';
import 'Model/LayerData.dart';

enum EditMode {
  initial,
  editProportion,
  editBackground,
  editItem,
  editColorWheel,
  editText,
  editStyleText,
}

class CartazViewModel extends ChangeNotifier {
  CartazViewModel();

  final double step = 3.0;
  late CartazModel model;
  // late CartazModel model = CartazModel(
  //     proportion: 1,
  //     backgroundColor: "30F010",
  //     content: [
  //       Line(text: "OFERTA", color: "000000", size: 70.0, weight: FontWeight.w900, padding: [0,20,0,20]),
  //       Line(text: "BANANA NANICA", color: "000000", size: 25.0),
  //       Line(text: "De: R\$ 10,40", color: "000000", size: 17.0),
  //       Line(text: "Por: R\$ 3,99", color: "000000", size: 40.0, weight: FontWeight.w900),
  //     ],
  //     layers: [
  //       LayerData(
  //         color: "FF0000",
  //         heightFraction: 0.2,
  //         pattern: PatternBackgroundType.triangular,
  //       ),
  //       LayerData(
  //         color: "FFFF00",
  //         heightFraction: 0.4,
  //         pattern: PatternBackgroundType.triangular,
  //       ),
  //       LayerData(
  //         color: "FF0000",
  //         heightFraction: 0.1,
  //         pattern: PatternBackgroundType.solid,
  //       ),
  //     ]);

  EditMode mode = EditMode.initial;

  int? selectedLayerIndex;
  int? selectedLineIndex;

  double get proportion => model.proportion;
  Color get backgroundColor => Color(int.parse('0xFF${model.backgroundColor}'));
  List<Line> get content => model.content;
  List<LayerData> get layers => model.layers;

  void initModel(CartazModel newModel) {
    model = newModel;
    mode = EditMode.initial;
    selectedLineIndex = null;
    selectedLayerIndex = null;
    notifyListeners();
  }

  bool isModeEqual(EditMode value) {
    if (value == EditMode.editStyleText) {
      return selectedLineIndex != null;
    }
    return mode == value;
  }

  bool isLayerSelected() {
    return (selectedLayerIndex != null && selectedLayerIndex! < layers.length);
  }

  bool isTextLayerSelected() {
    return (selectedLineIndex != null && selectedLineIndex! < content.length);
  }

  bool menuBottomIsOpen() {
    return mode == EditMode.initial || mode == EditMode.editProportion;
  }

  bool menuRightIsOpen() {
    return mode == EditMode.editBackground || mode == EditMode.editItem || mode == EditMode.editStyleText;
  }

  bool colorWheelIsOpen() {
    return mode == EditMode.editColorWheel;
  }

  bool editTextIsOpen() {
    return mode == EditMode.editText;
  }

  Size calculateCartazSize(Size screenSize) {
    double maxWidth = screenSize.width * 0.9;
    double maxHeight = screenSize.height * 0.6;

    double width = maxWidth;
    double height = width / proportion;

    if (height > maxHeight) {
      // ajusta largura com base no limite de altura
      height = maxHeight;
      width = height * proportion;
    }

    return Size(width, height);
  }

  void showColorWheelPicker() {
    if (isLayerSelected() || isTextLayerSelected()) {
      mode = EditMode.editColorWheel;
    }
    notifyListeners();
  }

  void closeEditText() {
    mode = EditMode.initial;
    selectedLineIndex = null;
    notifyListeners();
  }

  void closeColorWheelPicker() {
    if (isTextLayerSelected()) {
      mode = EditMode.editStyleText;
    } else {
      mode = EditMode.editBackground;
    }
    notifyListeners();
  }

  void setToEditBackground() {
    mode = EditMode.editBackground;
    selectedLayerIndex = 0;
    notifyListeners();
  }

  void layerSelected(int? index) {

    if (selectedLayerIndex != null) {
      selectedLayerIndex = null;
    } else {
      selectedLayerIndex = index;
    }

    notifyListeners();
  }

  void changeShapeLayer() {
    if (selectedLayerIndex != null) {
      final current = layers[selectedLayerIndex!].pattern;

      final allPatterns = PatternBackgroundType.values;
      final currentIndex = allPatterns.indexOf(current);
      final nextIndex = (currentIndex + 1) % allPatterns.length;
      final nextPattern = allPatterns[nextIndex];

      layers[selectedLayerIndex!].pattern = nextPattern;
      notifyListeners();
    }
  }

  void setProportionRules(List<double> values) {
    values.sort();

    List<double> newFractions = [];
    double previous = 0.0;

    for (double position in values) {
      newFractions.add(position - previous);
      previous = position;
    }
    newFractions.add(1.0 - previous); // último segmento

    if (newFractions.length != layers.length) {
      throw Exception('Número de frações não bate com o número de layers.');
    }

    //aqui n ta funcionando parece
    for (int i = 0; i < layers.length; i++) {
      layers[i].heightFraction = newFractions[i];
    }

    notifyListeners();
  }

  void closeProportionRules() {
    selectedLayerIndex = null;
    mode = EditMode.initial;
    notifyListeners();
  }

  void showProportionsValues() {
    mode = EditMode.editProportion;
    notifyListeners();
  }

  bool isSelected(double value) {
    return value == model.proportion;
  }

  void setProportions(double value) {
    model.proportion = value;
    notifyListeners();
  }

  void closeProportions() {
    mode = EditMode.initial;
    notifyListeners();
  }

  void setColor(String color) {
    if (isTextLayerSelected()) {
      content[selectedLineIndex!].color = color;
      notifyListeners();
    } else if (selectedLayerIndex != null) {
      notifyListeners();
      layers[selectedLayerIndex!].color = color;
    }
  }

  void showTextChangeOverlay() {
    mode = EditMode.editText;
    notifyListeners();
  }

  void closeTextChangeOverlay() {
    mode = EditMode.initial;
    notifyListeners();
  }

  String getCurrentText() {
    if (isTextLayerSelected()) {
      return content[selectedLineIndex!].text;
    } else {
      return "";
    }
  }

  void setNewText(String text) {
    if (isTextLayerSelected()) {
      content[selectedLineIndex!].text = text;
    }

    closeTextChangeOverlay();

    notifyListeners();
  }

  void resetAll() {
    selectedLineIndex = null;
    selectedLayerIndex = null;
    mode = EditMode.initial;
    notifyListeners();
  }

  void setSelectedLineIndex(int? index) {
   if (selectedLineIndex != null) {
      selectedLineIndex = null;
      mode = EditMode.initial;
   } else {
      selectedLineIndex = index;
      mode = EditMode.editStyleText;
   }

    notifyListeners();
  }

  void addLine() {
    model.content.add(Line(text: "Teste", color: "000000", size: 30.0));
    // _showTextChange = true;
    // _selectedLineIndex = content.length;
    notifyListeners();
  }

  void deleteLine() {
    if (selectedLineIndex != null &&
        selectedLineIndex! >= 0 &&
        selectedLineIndex! < model.content.length) {
      model.content.removeAt(selectedLineIndex!);
      selectedLineIndex = null;
      mode = EditMode.initial;
      notifyListeners();
    }
  }

  void changeBold() {
    final weights = [
      FontWeight.w300,
      FontWeight.w400,
      FontWeight.w500,
      FontWeight.w600,
      FontWeight.w700,
      FontWeight.w800,
      FontWeight.w900,
    ];

    if (isTextLayerSelected()) {
      final current = content[selectedLineIndex!].weight;
      final index = weights.indexOf(current);
      final nextWeight = (index + 1 < weights.length) ? weights[index + 1] : weights[0];

      content[selectedLineIndex!].weight = nextWeight;
      notifyListeners();
    }
  }

  void increaseText() {
    if (isTextLayerSelected()) {
      content[selectedLineIndex!].size++;
      notifyListeners();
    }
  }

  void decreaseText() {
    if (isTextLayerSelected()) {
      content[selectedLineIndex!].size--;
      notifyListeners();
    }
  }

  Alignment getAlignment() {
    if (isTextLayerSelected()) {
      return content[selectedLineIndex!].align;
    }
    return Alignment.center;
  }

  void changeHorizontalAlign() {
    Alignment current;
    if (isTextLayerSelected()) {
      current = content[selectedLineIndex!].align;
    } else {
      return;
    }

    final double horizontal = current.y;

    double newHorizontal;
    if (current.x == -1.0) {
      newHorizontal = 0.0;
    } else if (current.x == 0.0) {
      newHorizontal = 1.0;
    } else {
      newHorizontal = -1.0;
    }


    if (isTextLayerSelected()) {
      content[selectedLineIndex!].align = Alignment(newHorizontal, horizontal);
    }

    notifyListeners();
  }

  void changeVerticalAlign() {
     Alignment current;
      if (isTextLayerSelected()) {
        current = content[selectedLineIndex!].align;
      } else {
        return;
      }

      final double vertical = current.x;

      double newVertical;
      if (current.y == -1.0) {
        newVertical = 0.0;
      } else if (current.y == 0.0) {
        newVertical = 1.0;
      } else {
        newVertical = -1.0;
      }

     if (isTextLayerSelected()) {
       content[selectedLineIndex!].align = Alignment(vertical, newVertical);
     }

      notifyListeners();
  }

  void increaseHeight() {
    final line = content[selectedLineIndex!];
    for (var side in [IndexPaddings.top, IndexPaddings.bottom]) {
      final current = line.padding[side.number];
      line.setPaddingValue([side], current + step);
    }
    notifyListeners();
  }

  void decreaseHeight() {
    final line = content[selectedLineIndex!];
    for (var side in [IndexPaddings.top, IndexPaddings.bottom]) {
      final current = line.padding[side.number];
      line.setPaddingValue([side], (current - step).clamp(0, double.infinity));
    }
    notifyListeners();
  }
}