import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_enum/models/todo_list_status.dart';

import '../providers/active_todo_count_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/todo_list_provider.dart';

class TodoHeader extends ConsumerWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListState = ref.watch(todoListProvider);
    final active = ref.watch(activeTodoCountProvider);
    final theme = ref.watch(themeProvider);

    if (todoListState.status == TodoListStatus.loading) {
      context.loaderOverlay.show();
    } else {
      context.loaderOverlay.hide();
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Todos',
          style: TextStyle(fontSize: 36.0),
        ),
        const SizedBox(width: 10),
        Text(
          '($active / ${todoListState.todos.length} item${active >= 1 ? 's' : ''} left)',
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.blue,
          ),
        ),
        const Spacer(),
        Row(
          children: [
            IconButton(
              onPressed: todoListState.status == TodoListStatus.loading
                  ? null
                  : () => ref.read(themeProvider.notifier).toggleTheme(),
              icon: Icon(
                  theme == AppTheme.light ? Icons.light_mode : Icons.dark_mode),
            ),
            IconButton(
              onPressed: todoListState.status == TodoListStatus.loading
                  ? null
                  : () => ref.read(todoListProvider.notifier).fetchTodos(),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ],
    );
  }
}
