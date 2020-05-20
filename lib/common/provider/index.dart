import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 这里使用了 mixin 混入了 ChangeNotifier 这个类能够帮驻我们自动管理所有听众
// 当调用 notifyListeners() 时，它会通知所有听众进行刷新
class CounterModel with ChangeNotifier {
  int _count = 0;
  String _str = "";
  int get value => _count;
  String get name => _str;

  void increment() {
    _count++;
    notifyListeners();
  }

  void initName(String name) {
    _str = name;
    notifyListeners();
  }
}
