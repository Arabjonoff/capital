import 'package:capital/src/database_helper/database_helper.dart';
import 'package:capital/src/models/world/world.dart';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{
  final List<World> words = [];
  bool showCity = false;

  initList({String? word, bool? isCity}) async {
    words.clear();
    if (word == null) {
      words.addAll(await DatabaseHelper.instance.getWorld());
    } else {
      words.addAll(await DatabaseHelper.instance.getWorldLike(word, isCity!));
    }
    notifyListeners();
  }

  change() {
    showCity = !showCity;
    notifyListeners();
  }
}