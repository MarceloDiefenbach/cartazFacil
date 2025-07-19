import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'Features/Cartaz/CartazModel.dart';

class ManageCartazes extends ChangeNotifier {
  List<CartazModel> listCartaz = [];
  int? selectedIndex;

  CartazModel? get selectedCartaz =>
      (selectedIndex != null && selectedIndex! < listCartaz.length)
          ? listCartaz[selectedIndex!]
          : null;

  /// Caminho do arquivo
  Future<File> get _localFile async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/cartazes.json');
  }

  /// Inicializa dados do arquivo (ou cria novo)
  Future<void> initCartazes() async {
    final file = await _localFile;
    if (await file.exists()) {
      final jsonStr = await file.readAsString();
      final List<dynamic> jsonList = json.decode(jsonStr);
      listCartaz = jsonList.map((e) => CartazModel.fromJson(e)).toList();
    } else {
      // Cria um cartaz padrão se não houver arquivo
      createNewCartaz();
      await saveToDisk();
    }
    notifyListeners();
  }

  /// Salva no arquivo
  Future<void> saveToDisk() async {
    final file = await _localFile;
    final jsonList = listCartaz.map((e) => e.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }

  CartazModel? createNewCartaz({
    double proportion = 1.0,
    String backgroundColor = 'FFFFFF',
  }) {
    final newCartaz = CartazModel(
      proportion: proportion,
      backgroundColor: backgroundColor,
    );
    listCartaz.add(newCartaz);
    selectedIndex = listCartaz.length - 1;
    saveToDisk();
    notifyListeners();

    return getCurrentCartaz();
  }

  void saveCartaz(CartazModel updated) {
    if (selectedIndex != null && selectedIndex! < listCartaz.length) {
      listCartaz[selectedIndex!] = updated;
      saveToDisk();
      notifyListeners();
    }
  }

  void deleteCartaz(int index) {
    if (index >= 0 && index < listCartaz.length) {
      listCartaz.removeAt(index);
      if (selectedIndex == index) {
        selectedIndex = null;
      } else if (selectedIndex != null && selectedIndex! > index) {
        selectedIndex = selectedIndex! - 1;
      }
      saveToDisk();
      notifyListeners();
    }
  }

  void selectCartaz(CartazModel cartaz) {
    final index = listCartaz.indexWhere((item) => item.id == cartaz.id);
    if (index != -1) {
      selectedIndex = index;
      notifyListeners();
    }
  }

  CartazModel? getCurrentCartaz() {
    if ((selectedIndex != null) && (selectedIndex! < listCartaz.length))
      return listCartaz[selectedIndex!];
    else
      return null;
  }
}

