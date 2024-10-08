import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'widgets/filter_todo.dart';
import 'widgets/new_todo.dart';
import 'widgets/search_todo.dart';
import 'widgets/show_todos.dart';
import 'widgets/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LoaderOverlay(
          useDefaultLoading: false,
          overlayWidgetBuilder: (_) => const Center(
            child: SpinKitFadingCircle(
              color: Colors.grey,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TodoHeader(),
                NewTodo(),
                SizedBox(height: 20),
                SearchTodo(),
                SizedBox(height: 10),
                FilterTodo(),
                SizedBox(height: 10),
                Expanded(child: ShowTodos()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
