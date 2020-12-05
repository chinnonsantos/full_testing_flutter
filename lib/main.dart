import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:full_testing_flutter/counter.dart';
import 'package:full_testing_flutter/anti_counter.dart';

void main() {
  // Provider throws the following error:
  // "Tried to use Provider with a subtype of Listenable/Stream (AntiCounter)."
  // To fix this we tell Provider not to produce this message during debug.
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MultiProvider merges multiple providers into a single linear widget
    // tree. It is used to improve readability and reduce boilerplate code of
    // having to nest multiple layers of providers.
    return MultiProvider(
      providers: [
        // Provide the model to all widgets within the app. We're using
        // ChangeNotifierProvider because that's a simple way to rebuild
        // widgets when a model changes. We could also just use
        // Provider, but then we would have to listen to Counter ourselves.
        //
        // Read Provider's docs to learn about all the available providers.
        ChangeNotifierProvider(
          // Initialize the model in the builder. That way, Provider
          // can own Counter's lifecycle, making sure to call `dispose`
          // when not needed anymore.
          create: (context) => Counter(),
        ),
        // ProxyProvider is a provider that combines multiple values from other
        // providers into a new object, and sends the result to Provider.
        // That new object will then be updated whenever one of the providers it
        // depends on updates (Counter in this case).
        ProxyProvider<Counter, AntiCounter>(
          update: (context, counter, antiCounter) =>
              AntiCounter(counter: counter),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Counter is:',
                ),
                // Consumer looks for an ancestor Provider widget
                // and retrieves its model (Counter, in this case).
                // Then it uses that model to build widgets, and will trigger
                // rebuilds if the model is updated.
                Consumer<Counter>(
                  builder: (context, counter, child) => Text(
                    '${counter.value}',
                    key: Key('counter'),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Anti-counter is:',
                ),
                Consumer<AntiCounter>(
                  builder: (context, antiCounter, child) => Text(
                    '${antiCounter.value}',
                    key: Key('antiCounter'),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            // Provider.of is another way to access the model object held
            // by an ancestor Provider. By default, even this listens to
            // changes in the model, and rebuilds the whole encompassing widget
            // when notified.
            //
            // By using `listen: false` below, we are disabling that
            // behavior. We are only calling a function here, and so we don't care
            // about the current value. Without `listen: false`, we'd be rebuilding
            // the whole MyHomePage whenever Counter notifies listeners.
            key: Key('decrement'),
            onPressed: () =>
                Provider.of<Counter>(context, listen: false).decrement(),
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            key: Key('increment'),
            onPressed: () =>
                Provider.of<Counter>(context, listen: false).increment(),
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
