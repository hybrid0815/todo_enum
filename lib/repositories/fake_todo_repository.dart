import 'dart:math';

import 'package:todo_enum/models/todo_model.dart';
import 'package:todo_enum/repositories/todos_repository.dart';

final initalTodos = [
  {'id': '1', 'desc': 'Clean the room', 'complieted': false},
  {'id': '2', 'desc': 'Wash the dish', 'complieted': false},
  {'id': '3', 'desc': 'Do homework', 'complieted': false},
];

const double kProbabilityOfError = 0.5;
const int kDelayDuration = 1;

class FakeTodoRepository implements TodosRepository {
  List<Map<String, dynamic>> fakeTodos = initalTodos;
  final Random random = Random();

  Future<void> waitSecond() {
    return Future.delayed(const Duration(seconds: kDelayDuration));
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    await waitSecond();
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
    await waitSecond();
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
    await waitSecond();
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
    await waitSecond();
    try {
      if (random.nextDouble() < kProbabilityOfError) {
        throw 'Fail to toggleTodo.';
      }
      fakeTodos = [
        for (final todo in fakeTodos)
          if (todo['id'] == id)
            Todo.fromJson(todo)
                .copyWith(completed: !todo['complieted'])
                .toJson()
          else
            todo
      ];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeTodo({required String id}) async {
    await waitSecond();
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
