import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_enum/models/todo_model.dart';

part 'todo_list_status.freezed.dart';
part 'todo_list_status.g.dart';

enum TodoListStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class TodoListState with _$TodoListState {
  const factory TodoListState({
    required TodoListStatus status,
    required List<Todo> todos,
    @Default('') String error,
  }) = _TodoListState;

  factory TodoListState.initial() {
    return const TodoListState(
      status: TodoListStatus.initial,
      todos: [],
    );
  }

  factory TodoListState.fromJson(Map<String, dynamic> json) =>
      _$TodoListStateFromJson(json);
}
