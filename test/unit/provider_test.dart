import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:full_testing_flutter/main.dart';
import 'package:full_testing_flutter/counter.dart';

void main() async {
  Counter _counterModel;

  setUp(() {
    _counterModel = Counter();
  });

  group('[Provider]', () {
    testWidgets('Update when the value changes', (tester) async {
      final _providerKey = GlobalKey();
      BuildContext context;

      await tester.pumpWidget(ChangeNotifierProvider<Counter>(
        key: _providerKey,
        create: (c) {
          context = c;
          return Counter();
        },
        child: MyApp(),
      ));

      // Check the context test...
      expect(context, equals(_providerKey.currentContext));

      /// Only the descendants of the `ChangeNotifierProvider<T>`
      /// can call `Provider.of<T>`, so find his context...
      final BuildContext childContext = tester.element(find.byType(MyApp));

      // Check the initial value provider 0...
      expect(Provider.of<Counter>(childContext).value, 0);

      // Increment value...
      Provider.of<Counter>(childContext).increment();

      // Delay the pump...
      await Future.microtask(tester.pump);

      // Check incremented value...
      expect(Provider.of<Counter>(childContext).value, 1);

      // Decrement value...
      Provider.of<Counter>(childContext, listen: false).decrement();

      // Delay the pump...
      await Future.microtask(tester.pump);

      // Check decremented value...
      expect(Provider.of<Counter>(childContext).value, 0);
    });
  });
}
