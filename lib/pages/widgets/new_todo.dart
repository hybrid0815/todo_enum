import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_enum/models/todo_list_status.dart';

import '../providers/todo_list_provider.dart';

class NewTodo extends ConsumerStatefulWidget {
  const NewTodo({super.key});

  @override
  ConsumerState<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends ConsumerState<NewTodo> {
  final controller = TextEditingController();
  Widget prevWidget = const SizedBox.shrink();
  bool enableOrNot(TodoListStatus status) {
    switch (status) {
      case TodoListStatus.failure when prevWidget is SizedBox:
      case TodoListStatus.loading || TodoListStatus.initial:
        return false;
      case _:
        prevWidget = Container();
        return true;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todosState = ref.watch(todoListProvider);

    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'What to do?',
      ),
      enabled: enableOrNot(todosState.status),
      onSubmitted: (String? desc) {
        if (desc != null && desc.trim().isNotEmpty) {
          ref.read(todoListProvider.notifier).addTodo(desc: desc);
          controller.clear();
        }
      },
    );
  }
}
