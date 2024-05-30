import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int _count1 = 0;

  int get count1 => _count1;

  int _count2 = 0;

  int get count2 => _count2;
  void increment1() {
    _count1++;
       notifyListeners();
  }

  void increment2() {
    _count2++;
    notifyListeners();
  }
}
