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

  final _mutableProvider = StateProvider<MutableData>((ref) => MutableData());
  final _immutableProvider =
      StateProvider<ImmutableData>((ref) => ImmutableData(0));

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
              return Text(
                '${ref.watch(_mutableProvider).count}',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            Consumer(builder: (context, ref, child) {
              return Text(
                '${ref.watch(_immutableProvider).count}',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton(
          onPressed: () {
            final mutableData = ref.read(_mutableProvider);
            mutableData.countUp();
            ref.read(_mutableProvider.notifier).state = mutableData;

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

class MutableData {
  int count = 0;
  void countUp() {
    count++;
  }
}

class ImmutableData {
  ImmutableData(this.count);
  final int count;

  ImmutableData countUp() {
    return ImmutableData(count + 1);
  }
}
