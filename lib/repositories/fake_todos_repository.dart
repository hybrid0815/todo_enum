import 'dart:math';

import 'package:todo_enum/models/todo_model.dart';
import 'package:todo_enum/repositories/todos_repository.dart';

const initalTodos = [
  {'id': '1', 'desc': 'Clean the room', 'completed': false},
  {'id': '2', 'desc': 'Wash the dish', 'completed': false},
  {'id': '3', 'desc': 'Do homework', 'completed': false},
];

const double kProbabilityOfError = 0.5;
const int kDelayDuration = 1;

class FakeTodosRepository implements TodosRepository {
  List<Map<String, dynamic>> fakeTodos = initalTodos;
  final Random random = Random();

  Future<void> waitSecond(String message) {
    print(message);
    return Future.delayed(const Duration(seconds: kDelayDuration));
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    await waitSecond('API 서버에 데이터를 가져오는 중 ...');
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'Fail to fetchTodos.';
      }

      final todos = [for (final todo in fakeTodos) Todo.fromJson(todo)];
      return todos;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addTodo({required Todo todo}) async {
    await waitSecond('API 서버에 데이터를 추가 중 ...');
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'Fail to addTodo.';
      }

      fakeTodos = [...fakeTodos, todo.toJson()];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editTodo({required String id, required String desc}) async {
    await waitSecond('API 서버에 데이터를 변경중 ...');
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'Fail to editTodo.';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] == id)
            Todo.fromJson(todo).copyWith(desc: desc).toJson()
          else
            todo
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleTodo({required String id}) async {
    await waitSecond('API 서버에 데이터를 변경중 ...');
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'Fail to toggleTodo.';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] == id)
            Todo.fromJson(todo).copyWith(completed: !todo['completed']).toJson()
          else
            todo
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required String id}) async {
    await waitSecond('API 서버에 데이터를 삭제 중 ...');
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'Fail to removeTodo.';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] != id) todo
      ];
    } catch (e) {
      rethrow;
    }
  }
}
