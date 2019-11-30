// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:full_testing_flutter/counter.dart';

void main() {
  group('[Counter]', () {
    Counter _counter;

    setUp(() {
      _counter = Counter();
    });

    test('Counter initial value should be 0', () {
      expect(_counter.value, 0);
    });

    test('Counter class type should be `Counter`', () {
      expect(_counter.runtimeType, equals(Counter));
    });

    test('Counter value type should be `int`', () {
      expect(_counter.value.runtimeType, equals(int));
    });

    test('Counter value should not be `null`', () {
      expect(_counter.value, isNotNull);
    });

    test('Counter value should be incremented', () {
      _counter.increment();

      expect(_counter.value, 1);
    });

    test('Counter value should be decremented', () {
      _counter.decrement();

      expect(_counter.value, -1);
    });

    test('Counter value should be first incremented and then decremented', () {
      _counter.increment();
      _counter.decrement();

      expect(_counter.value, 0);
    });
  });
}
