import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:full_testing_flutter/main.dart';
import 'package:full_testing_flutter/counter.dart';
import 'package:full_testing_flutter/anti_counter.dart';

void main() async {
  group('[ProxyProvider]', () {
    testWidgets('Update when the value changes', (tester) async {
      final _proxyProviderKey = GlobalKey();

      BuildContext context;

      Provider.debugCheckInvalidValueType = null;

      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<Counter>(create: (_) => Counter()),
          ProxyProvider<Counter, AntiCounter>(
            key: _proxyProviderKey,
            update: (c, coutner, antiCounter) {
              context = c;
              return AntiCounter(counter: coutner);
            },
          ),
        ],
        child: MyApp(),
      ));

      // Check the context test...
      expect(context, equals(_proxyProviderKey.currentContext));

      /// Only the descendants of the `ChangeNotifierProvider<T>`
      /// can call `Provider.of<T>`, so find his context...
      final BuildContext childContext = tester.element(find.byType(MyApp));

      // Check the initial value provider 0...
      expect(Provider.of<Counter>(childContext).value, 0);

      // Check the initial value antiProvider 0...
      expect(Provider.of<AntiCounter>(childContext).value, 0);

      // Increment value...
      Provider.of<Counter>(childContext).increment();

      // Delay the pump...
      await Future.microtask(tester.pump);

      // Check Counter value...
      expect(Provider.of<Counter>(childContext).value, 1);

      // Check AntiCounter value...
      expect(Provider.of<AntiCounter>(childContext).value, -1);

      // Decrement value...
      Provider.of<Counter>(childContext).decrement();

      // Delay the pump...
      await Future.microtask(tester.pump);

      // Check Counter value...
      expect(Provider.of<Counter>(childContext).value, 0);

      // Check AntiCounter value...
      expect(Provider.of<AntiCounter>(childContext).value, 0);
    });
  });
}
