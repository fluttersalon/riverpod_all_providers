import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'main.g.dart';

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

@riverpod
String githubUrl(_) =>
    'https://api.github.com/search/repositories?q=[keyword]&page=[page]';

@riverpod
Future<String> repositoryTitle(RepositoryTitleRef ref,
    {required int page, required String keyword}) async {
  final url = ref
      .read(githubUrlProvider)
      .replaceAll('[keyword]', keyword)
      .replaceAll('[page]', page.toString());

  print('url: $url');

  final client = http.Client();
  final result = await client.get(Uri.parse(url));
  final map = json.decode(result.body) as Map<String, dynamic>;

  final title = map['items'][0]['name'];

  return title;
}

class MyHomePage extends ConsumerWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  int _page = 1;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ref
                .watch(repositoryTitleProvider(page: _page, keyword: 'flutter'))
                .when(
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => const Text('error'),
                  data: (title) => Text(
                    title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _page++;
          ref.invalidate(repositoryTitleProvider);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
