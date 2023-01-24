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

  final _normalListProvider = StateProvider<List<int>>((ref) => []);
  final _immutableListProvider = StateProvider<List<int>>((ref) => []);

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
                '${ref.watch(_normalListProvider).length}',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            Consumer(builder: (context, ref, child) {
              return Text(
                '${ref.watch(_immutableListProvider).length}',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FloatingActionButton(
          onPressed: () {
            final listInNormalUsage = ref.read(_normalListProvider);
            listInNormalUsage.add(0);
            ref.read(_normalListProvider.notifier).state = listInNormalUsage;

            final list = ref.read(_immutableListProvider);
            final newList = [...list, 0];
            ref.read(_immutableListProvider.notifier).state = newList;

            // → ref.read(_immutableListProvider.notifier)
            //      .update((state) => [...state, 0]);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
