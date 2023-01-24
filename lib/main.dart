import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  final _immutableProvider =
      StateProvider<ImmutableData>((ref) => ImmutableData(0, 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Consumer(builder: (context, ref, child) {
              print('Without select');
              return Text(
                '${ref.watch(_immutableProvider).sameValue}',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            Consumer(builder: (context, ref, child) {
              print('With select');
              return Text(
                '${ref.watch(_immutableProvider.select((e) => e.sameValue))}',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton(
          onPressed: () {
            final oldImmutableData = ref.read(_immutableProvider);
            final newImmutableData = oldImmutableData.countUp();
            ref.read(_immutableProvider.notifier).state = newImmutableData;
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}

class ImmutableData {
  ImmutableData(this.count, this.sameValue);
  final int count;
  final int sameValue;

  ImmutableData countUp() {
    return ImmutableData(count + 1, sameValue);
  }
}
