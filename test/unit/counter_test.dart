// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:full_testing_flutter/counter.dart';

void main() {
  group('Counter', () {
    Counter counter;

    setUp(() {
      counter = Counter();
    });

    test('Counter value should be incremented', () {
      counter.increment();

      expect(counter.value, 1);
    });

    test('Counter value should be decremented', () {
      counter.decrement();

      expect(counter.value, -1);
    });

    test('Counter value should be first incremented and then decremented', () {
      counter.increment();
      counter.decrement();

      expect(counter.value, 0);
    });
  });
}
