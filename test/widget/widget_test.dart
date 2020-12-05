// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:full_testing_flutter/main.dart';
import 'package:full_testing_flutter/counter.dart';
import 'package:full_testing_flutter/anti_counter.dart';

void main() {
  group('[Widget -> Main page]', () {
    Provider.debugCheckInvalidValueType = null;
    testWidgets('Counter increments test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<Counter>(create: (_) => Counter()),
          ProxyProvider<Counter, AntiCounter>(
              update: (c, counter, antiCounter) =>
                  AntiCounter(counter: counter)),
        ],
        child: MyApp(),
      ));

      // Verify that our counter starts at 0.
      expect(find.text('0'), findsNWidgets(2));
      expect(find.text('1'), findsNothing);

      // verify if have a 'Floating Action Button' widget.
      expect(find.byType(FloatingActionButton), findsNWidgets(2));

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      // Rebuild the widget with the new value.
      await tester.pump();

      // Verify that our counter has incremented and anticounter has decremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
      expect(find.text('-1'), findsOneWidget);
    });

    testWidgets('Default text test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Verify text:.
      expect(find.text('Counter is:'), findsOneWidget);
      expect(find.text('Anti-counter is:'), findsOneWidget);
    });
  });
}
