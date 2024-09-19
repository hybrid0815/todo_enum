import 'package:todo_enum/models/todo_model.dart';

abstract class TodosPrepository {
  Future<List<Todo>> fetchTodos();
  Future<void> addTodo({required Todo todo});
  Future<void> editTodo({required String id, required String desc});
  Future<void> toggleTodo({required String id});
  Future<void> removeTodo({required String id});
}
