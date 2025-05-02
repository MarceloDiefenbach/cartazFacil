import 'package:flutter/material.dart';
import 'CartazModel.dart';

class CartazViewModel extends ChangeNotifier {
  CartazViewModel();

  late CartazModel model = CartazModel(
      title: Line(text: "OFERTA", color: "000000", size: 50.0, weight: FontWeight.w900),
      proportion: 1,
      backgroundColor: "30F010",
      content: [
        Line(text: "BANANA NANICA", color: "000000", size: 25.0),
        Line(text: "De: R\$ 10,40", color: "000000", size: 17.0),
        Line(text: "Por: R\$ 3,99", color: "000000", size: 40.0, weight: FontWeight.w900),
      ]);

  bool _showToolbar = false;
  bool get showToolbar => _showToolbar;

  bool _showProportions = false;
  bool get showProportions => _showProportions;

  bool _showColorWheel = false;
  bool get showColorWheel => _showColorWheel;



  int? _selectedLineIndex;
  int? get selectedLineIndex => _selectedLineIndex;

  bool? _selectTitle;
  bool? get selectTitle => _selectTitle;

  Line get title => model.title;
  double get proportion => model.proportion;
  Color get backgroundColor => Color(int.parse('0xFF${model.backgroundColor}'));
  List<Line> get content => model.content;


  void initModel(CartazModel newModel) {
    model = newModel;
    notifyListeners();
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

  void toggleToolbar([bool? force]) {
    _showToolbar = force ?? !_showToolbar;
    if (_showToolbar) _showProportions = false;
    notifyListeners();
  }


  void showColorWheelPicker() {
    _showProportions = false;
    _showColorWheel = true;
    notifyListeners();
  }

  void closeColorWheelPicker() {
    _showProportions = false;
    _showColorWheel = false;
    notifyListeners();
  }

  void showProportionsValues() {
    _showProportions = true;
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
    _showProportions = false;
    notifyListeners();
  }

  void setBackgroundColor(String color) {
    model.backgroundColor = color;
    notifyListeners();
  }

  void resetSelectedLineIndex() {
    _selectedLineIndex = null;
    _showToolbar = false;
    notifyListeners();
  }

  void resetAll() {
    _selectTitle = null;
    resetSelectedLineIndex();
  }

  void setSelectTitle() {
    if (_showToolbar) {
      _selectTitle = null;
      _selectedLineIndex = null;
    } else {
      _selectTitle = true;
      _selectedLineIndex = null;
    }

    toggleToolbar();

    notifyListeners();
  }

  void setSelectedLineIndex(int? index) {
    if (_selectTitle == true) {
      toggleToolbar(false);
      _selectedLineIndex = null;
      _selectTitle = null;
    } else if (_selectedLineIndex != null) {
      _selectedLineIndex = null;
      toggleToolbar(false);
    } else {
      _selectedLineIndex = index;
      toggleToolbar(true);
    }

    notifyListeners();
  }

  bool checkExistIndex() {
    return (_selectedLineIndex != null && _selectedLineIndex! < content.length);
  }

  bool checkExistTitle() {
    return (_selectTitle != null && _selectTitle!);
  }

  void addLine() {
    model.content.add(Line(text: "Teste", color: "000000", size: 30.0));
    notifyListeners();
  }

  void deleteLine() {
    if (_selectedLineIndex != null &&
        _selectedLineIndex! >= 0 &&
        _selectedLineIndex! < model.content.length) {
      model.content.removeAt(_selectedLineIndex!);
      _selectedLineIndex = null;
      _showToolbar = false;
      notifyListeners();
    }
  }

  void editText() {

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

    if (checkExistIndex()) {
      final current = content[_selectedLineIndex!].weight;
      final index = weights.indexOf(current);
      final nextWeight = (index + 1 < weights.length) ? weights[index + 1] : weights[0];

      content[_selectedLineIndex!].weight = nextWeight;
      notifyListeners();
    } else if (checkExistTitle()) {
      final current = title.weight;
      final index = weights.indexOf(current);
      final nextWeight = (index + 1 < weights.length) ? weights[index + 1] : weights[0];

      title.weight = nextWeight;
      notifyListeners();
    }
  }

  void increaseText() {
    if (checkExistIndex()) {
      content[_selectedLineIndex!].size++;
      notifyListeners();
    } else if (checkExistTitle()){
      title.size++;
      notifyListeners();
    }
  }

  void decreaseText() {
    if (checkExistIndex()) {
      content[_selectedLineIndex!].size--;
      notifyListeners();
    } else if (checkExistTitle()){
      title.size--;
      notifyListeners();
    }
  }

  Alignment getAlignment() {
    if (checkExistIndex()) {
      return content[_selectedLineIndex!].align;
    } else if (checkExistTitle()) {
      return title.align;
    }
    return Alignment.center;
  }

  void changeHorizontalAlign() {
    Alignment current;
    if (checkExistIndex()) {
      current = content[_selectedLineIndex!].align;
    } else if (checkExistTitle()) {
      current = title.align;
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


    if (checkExistIndex()) {
      content[_selectedLineIndex!].align = Alignment(newHorizontal, horizontal);
    } else if (checkExistTitle()) {
      title.align = Alignment(newHorizontal, horizontal);
    }
      notifyListeners();
  }

  void changeVerticalAlign() {
     Alignment current;
      if (checkExistIndex()) {
        current = content[_selectedLineIndex!].align;
      } else if (checkExistTitle()) {
        current = title.align;
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

     if (checkExistIndex()) {
       content[_selectedLineIndex!].align = Alignment(vertical, newVertical);
     } else if (checkExistTitle()) {
       title.align = Alignment(vertical, newVertical);
     }

      notifyListeners();
  }

}