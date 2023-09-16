import 'package:flutter/material.dart';

class FlagProvider extends ChangeNotifier {
  bool? isDownloaded = false;
  bool? get getIsDownloaded => isDownloaded;

  downloaded(bool? value) {
    isDownloaded = value;
    notifyListeners();
  }

  int? imgIndex;
  int? get getimgIndex => imgIndex;

  setIndex(int? value) {
    imgIndex = value;
    notifyListeners();
  }
}
