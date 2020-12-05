// Import the test package, Counter and AntiCounter class
import 'package:test/test.dart';
import 'package:full_testing_flutter/counter.dart';
import 'package:full_testing_flutter/anti_counter.dart';

void main() {
  group('[AntiCounter]', () {
    Counter _counter;
    AntiCounter _antiCounter;

    setUp(() {
      _counter = Counter();
      _antiCounter = AntiCounter(counter: _counter);
    });

    test('AntiCounter initial value should be 0', () {
      expect(_antiCounter.value, 0);
    });

    test('AntiCounter class type should be `AntiCounter`', () {
      expect(_antiCounter.runtimeType, equals(AntiCounter));
    });

    test('AntiCounter value type should be `int`', () {
      expect(_antiCounter.value.runtimeType, equals(int));
    });

    test('AntiCounter value should not be `null`', () {
      expect(_antiCounter.value, isNotNull);
    });

    test('AntiCounter value should decrement when Counter value increases', () {
      _counter.increment();

      expect(_antiCounter.value, -1);
    });

    test('AntiCounter value should increment when Counter value decreases', () {
      _counter.decrement();

      expect(_antiCounter.value, 1);
    });

    test('AntiCounter value should be first decremented and then incremented',
        () {
      _counter.increment();
      _counter.decrement();

      expect(_antiCounter.value, 0);
    });
  });
}
