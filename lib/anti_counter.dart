import 'package:flutter/foundation.dart';

import 'counter.dart';

/// Simplest possible model to showcase dependency injection.
///
/// [AntiCounter] depends on [Counter] for it's [value].
class AntiCounter with ChangeNotifier {
  final Counter _counter;

  AntiCounter({@required Counter counter}) : _counter = counter;

  /// Value of [AntiCounter], which is simply negative of what [Counter]'s value
  /// is.
  /// Notice, there is no setter declared for [value], this is by design. We
  /// want to recreate [AntiCounter] object everytime [Counter]'s value changes.
  int get value {
    return -_counter.value;
  }
}
