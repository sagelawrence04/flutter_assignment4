import 'package:flutter/material.dart';
import 'package:assignment_4/models/todo.dart';
import 'package:assignment_4/views/todo_item.dart';

/// A widget that represents a list of todos
class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo) onToggle;
  final Function(Todo) onLongPress;

  const TodoList({
    super.key,
    required this.todos,
    required this.onToggle,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 480) {
        return ListView.builder(
          physics: const ClampingScrollPhysics(),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return TodoItem(
              todo: todo,
              smallScreen: true,
              onToggle: onToggle,
              onLongPress: onLongPress,
            );
          },
        );
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return TodoItem(
            todo: todo,
            smallScreen: false,
            onToggle: onToggle,
            onLongPress: onLongPress,
          );
        },
      );
    });
  }
}
