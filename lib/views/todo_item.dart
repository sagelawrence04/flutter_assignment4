import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:assignment_4/models/todo.dart';

/// A widget that represents one to-do
class TodoItem extends StatelessWidget {
  final Todo todo;
  final bool smallScreen;
  final Function(Todo) onToggle;
  final Function(Todo) onLongPress;

  const TodoItem({
    super.key,
    required this.todo,
    required this.smallScreen,
    required this.onToggle,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    String notes = "";
    String due = "";
    if (todo.notes != null) {
      notes = "${todo.notes}\n";
    }
    if (todo.due != null) {
      due = "Due on: ${DateFormat.yMd().add_Hms().format(todo.due!)}";
    }

    return GestureDetector(
      onLongPress: () => onLongPress(todo),
      child: CheckboxListTile(
        value: todo.completed,
        onChanged: (_) => onToggle(todo),
        title: Text(todo.value),
        isThreeLine: true,
        subtitle: Text(
          "$notes$due",
        ),
      ),
    );
  }
}
