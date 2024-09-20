import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_enum/repositories/fake_todo_repository.dart';
import 'package:todo_enum/repositories/providers/todos_repository_provider.dart';

import 'pages/providers/theme_provider.dart';
import 'pages/todos_page.dart';

void main() {
  runApp(ProviderScope(
    overrides: [
      todosRepositoryProvider.overrideWithValue(FakeTodoRepository())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Todos',
      debugShowCheckedModeBanner: false,
      theme: theme == AppTheme.light ? ThemeData.light() : ThemeData.dark(),
      home: const TodosPage(),
    );
  }
}
