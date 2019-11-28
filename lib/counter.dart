import 'package:flutter/foundation.dart';

/// Simplest possible model, with just one field.
///
/// [ChangeNotifier] is a class in `flutter:foundation`.
/// [Counter] does _not_ depend on Provider.
class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    value++;
    // print('Value++: $value');
    notifyListeners();
  }

  void decrement() {
    value--;
    // print('Value--: $value');
    notifyListeners();
  }
}
