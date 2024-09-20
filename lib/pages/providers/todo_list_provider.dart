import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_enum/models/todo_list_status.dart';
import 'package:todo_enum/models/todo_model.dart';
import 'package:todo_enum/repositories/providers/todos_repository_provider.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  TodoListState build() {
    return TodoListState.initial();
  }

  Future<void> fetchTodos() async {
    setLoading();

    try {
      final todos = await ref.read(todosRepositoryProvider).fetchTodos();
      state = state.copyWith(
        status: TodoListStatus.success,
        todos: todos,
      );
    } catch (e) {
      setError(e);
    }
  }

  Future<void> addTodo({required String desc}) async {
    setLoading();

    try {
      final todo = Todo.add(desc: desc);
      await ref.read(todosRepositoryProvider).addTodo(todo: todo);
      state = state.copyWith(
        status: TodoListStatus.success,
        todos: [...state.todos, todo],
      );
    } catch (e) {
      setError(e);
    }
  }

  Future<void> editTodo(String id, String desc) async {
    setLoading();

    try {
      await ref.read(todosRepositoryProvider).editTodo(id: id, desc: desc);
      state = state.copyWith(
        status: TodoListStatus.success,
        todos: [
          for (final todo in state.todos)
            if (todo.id == id) todo.copyWith(desc: desc) else todo
        ],
      );
    } catch (e) {
      setError(e);
    }
  }

  Future<void> toggleTodo(String id) async {
    setLoading();
    try {
      await ref.read(todosRepositoryProvider).toggleTodo(id: id);
      state = state.copyWith(
        status: TodoListStatus.success,
        todos: [
          for (final todo in state.todos)
            if (todo.id == id)
              todo.copyWith(completed: !todo.completed)
            else
              todo
        ],
      );
    } catch (e) {
      setError(e);
    }
  }

  Future<void> removeTodo(String id) async {
    setLoading();
    try {
      await ref.read(todosRepositoryProvider).removeTodo(id: id);
      state = state.copyWith(
        status: TodoListStatus.success,
        todos: [
          for (final todo in state.todos)
            if (todo.id != id) todo
        ],
      );
    } catch (e) {
      setError(e);
    }
  }

  void setLoading() {
    state = state.copyWith(
      status: TodoListStatus.loading,
    );
  }

  void setError(Object e) {
    state = state.copyWith(
      status: TodoListStatus.failure,
      error: e.toString(),
    );
  }
}
