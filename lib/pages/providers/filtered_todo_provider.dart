import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/todo_model.dart';
import 'todo_filter_provider.dart';
import 'todo_list_provider.dart';
import 'todo_search_provider.dart';

part 'filtered_todo_provider.g.dart';

@riverpod
List<Todo> filterdTodos(FilterdTodosRef ref) {
  final todoListState = ref.watch(todoListProvider);
  final filter = ref.watch(todoFilterProvider);
  final search = ref.watch(todoSearchProvider);

  List<Todo> tempTodos;

  tempTodos = switch (filter) {
    Filter.active =>
      todoListState.todos.where((todo) => !todo.completed).toList(),
    Filter.completed =>
      todoListState.todos.where((todo) => todo.completed).toList(),
    Filter.all => todoListState.todos,
  };

  if (search.isNotEmpty) {
    tempTodos = tempTodos
        .where((todo) => todo.desc.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  return tempTodos;
}
