import 'dart:io';

class AdHelper {

  static String get homeBanner {
    if (Platform.isAndroid) {
      return 'ca-app-pub-7490663355066325/6312828804';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7490663355066325/1004661807';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get productListBanner {
    if (Platform.isAndroid) {
      return "ca-app-pub-7490663355066325/9114800705";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7490663355066325/5929685420";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get encarteBanner {
    if (Platform.isAndroid) {
      return "ca-app-pub-7490663355066325/2182012106";
    } else if (Platform.isIOS) {
      return "ca-app-pub-7490663355066325/3231918636";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}