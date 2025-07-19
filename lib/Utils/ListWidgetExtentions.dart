import 'package:flutter/cupertino.dart';

// Para Column (vertical)
extension SeparatedColumnChildren on List<Widget> {
  List<Widget> withVerticalSpacing({double height = 8.0}) {
    if (isEmpty) return [];
    final spaced = <Widget>[];
    for (var i = 0; i < length; i++) {
      spaced.add(this[i]);
      if (i != length - 1) {
        spaced.add(SizedBox(height: height));
      }
    }
    return spaced;
  }
}

// Para Row (horizontal)
extension SeparatedRowChildren on List<Widget> {
  List<Widget> withHorizontalSpacing({double width = 8.0}) {
    if (isEmpty) return [];
    final spaced = <Widget>[];
    for (var i = 0; i < length; i++) {
      spaced.add(this[i]);
      if (i != length - 1) {
        spaced.add(SizedBox(width: width));
      }
    }
    return spaced;
  }
}

extension SplitExtension<T> on List<T> {
  List<List<T>> split(int size) {
    final List<List<T>> chunks = [];
    for (var i = 0; i < length; i += size) {
      final end = (i + size < length) ? i + size : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }
}