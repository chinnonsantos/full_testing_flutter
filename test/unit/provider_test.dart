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

      // // Check the initial value provider 0...
      // expect(Provider.of<Counter>(_providerKey.currentContext).value, 0);

      // // Increment value...
      // Provider.of<Counter>(_providerKey.currentContext).increment();

      // // Delay the pump...
      // await Future.microtask(tester.pump);

      // // Check if incremented value is the same as received...
      // expect(
      //   Consumer<Counter>(
      //     builder: (context, counter, child) => Text('${counter.value}'),
      //   ),
      //   _counterModel.value,
      // );

      // // Decrement value...
      // Provider.of<Counter>(context, listen: false).decrement();

      // // Delay the pump...
      // await Future.microtask(tester.pump);

      // // Check if decremented value is the same as received...
      // expect(
      //   Provider.of<Counter>(_childKey.currentContext).value,
      //   _counterModel.value,
      // );
    });
  });
}
