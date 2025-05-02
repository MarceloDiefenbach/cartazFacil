import 'package:flutter/material.dart';
import '../../Model/CartazModel.dart';

class CartazViewModel extends ChangeNotifier {
  final CartazModel model;

  CartazViewModel(this.model);

  bool _showToolbar = true;
  bool get showToolbar => _showToolbar;

  String get title => model.title;
  Color get backgroundColor => Color(int.parse('0xFF${model.hexColor.replaceAll('#', '')}'));

  void toggleToolbar() {
    _showToolbar = !_showToolbar;
    notifyListeners();
  }
}