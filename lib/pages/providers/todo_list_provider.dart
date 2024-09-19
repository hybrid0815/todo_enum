import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/todo_model.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<Todo> build() {
    return [
      const Todo(id: '1', desc: 'Clean the room'),
      const Todo(id: '2', desc: 'Wash the dish'),
      const Todo(id: '3', desc: 'Do homework'),
    ];
  }

  void addTodo({required String desc}) {
    state = [...state, Todo.add(desc: desc)];
  }

  void editTodo(String id, String desc) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(desc: desc) else todo
    ];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(completed: !todo.completed) else todo
    ];
  }

  void removeTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id != id) todo
    ];
  }
}
