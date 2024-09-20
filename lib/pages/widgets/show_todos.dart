import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_enum/models/todo_list_status.dart';
import 'package:todo_enum/pages/providers/todo_list_provider.dart';

import '../providers/filtered_todo_provider.dart';
import '../providers/todo_item_provider.dart';
import 'todo_item.dart';

class ShowTodos extends ConsumerStatefulWidget {
  const ShowTodos({super.key});

  @override
  ConsumerState<ShowTodos> createState() => _ShowTodosState();
}

class _ShowTodosState extends ConsumerState<ShowTodos> {
  Widget prevTodosWidget = const SizedBox.shrink();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      print('[ShowTodos] fetchTodos()');
      // 페이지가 로딩이 끝나자마나 API에서 데이터 가저오기 시도
      ref.read(todoListProvider.notifier).fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[ShowTodos] build()');

    // 처음 로딩시에는 TodoListStatus.loading
    // 페이지 로딩이후 API에서 데이터 가저올때 실패하면 다이얼로그에 에러 표시
    ref.listen<TodoListState>(todoListProvider, (previous, next) {
      if (next.status == TodoListStatus.failure) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error', textAlign: TextAlign.center),
              content: Text(next.error, textAlign: TextAlign.center),
            );
          },
        );
      }
    });

    // 처음 로딩이을 거치고 에러도 없을시 상태를 알기위해
    final todoListState = ref.watch(todoListProvider);

    switch (todoListState.status) {
      // enum type 검사
      case TodoListStatus.initial:
        return const SizedBox.shrink();
      case TodoListStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case TodoListStatus.failure when prevTodosWidget is SizedBox:
        return buildErrorCase(todoListState);
      case TodoListStatus.failure:
      case TodoListStatus.success:
        prevTodosWidget = buildSuccessCase();
        return prevTodosWidget;
    }
  }

  Widget buildErrorCase(TodoListState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.error,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              ref.read(todoListProvider.notifier).fetchTodos();
            },
            child: const Text(
              'Please Retry!',
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSuccessCase() {
    final filterdTodos = ref.watch(filterdTodosProvider);
    return ListView.separated(
      itemCount: filterdTodos.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final todo = filterdTodos[index];
        return ProviderScope(
          overrides: [
            todoItemProvider.overrideWithValue(todo),
          ],
          child: const TodoItem(),
        );
      },
    );
  }
}
