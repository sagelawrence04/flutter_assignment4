import 'package:flutter/material.dart';
import 'package:assignment_4/models/todo.dart';
import 'package:assignment_4/repositories/todo_repository.dart';
import 'package:assignment_4/views/todo_list.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TodoRepository repository = TodoRepository();
  var todos = <Todo>[];

  @override
  void initState() {
    super.initState();
    todos = repository.getTodos();
  }

  void _removeCompletedTodos() {
    setState(() {
      todos.removeWhere((todo) => todo.completed);
    });
  }

  void _addTodo(Todo newTodo) {
    setState(() {
      todos.add(newTodo);
    });
  }

  void _showAddTodoDialog() {
    final TextEditingController valueController = TextEditingController();
    final TextEditingController notesController = TextEditingController();
    DateTime? dueDate;
    TimeOfDay? dueTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add To-do'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: valueController,
                  decoration: const InputDecoration(labelText: 'Value (required)'),
                ),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Notes (optional)'),
                ),
                ListTile(
                  title: const Text("Due Date"),
                  subtitle: Text(dueDate == null
                      ? "Select a date"
                      : DateFormat.yMd().format(dueDate!)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: dueDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    setState(() {
                      dueDate = selectedDate;
                    });
                  },
                ),
                ListTile(
                  title: const Text("Due Time"),
                  subtitle: Text(dueTime == null
                      ? "Select a time"
                      : dueTime!.format(context)),
                  trailing: const Icon(Icons.access_time),
                  onTap: () async {
                    final TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: dueTime ?? TimeOfDay.now(),
                    );
                    setState(() {
                      dueTime = selectedTime;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (valueController.text.isNotEmpty) {
                  final newTodo = Todo(
                    value: valueController.text,
                    notes: notesController.text.isEmpty ? null : notesController.text,
                    due: dueDate != null ? DateTime(
                      dueDate!.year,
                      dueDate!.month,
                      dueDate!.day,
                      dueTime?.hour ?? 0, // Use hour from dueTime if not null, else default to 0
                      dueTime?.minute ?? 0, // Use minute from dueTime if not null, else default to 0
                    ) : null,
                  );
                  _addTodo(newTodo);
                  Navigator.of(context).pop();
                } else {
                  // Show a message or indication that the value is required
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Value is required')),
                  );
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'remove_completed') {
                _removeCompletedTodos();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'remove_completed',
                child: Text('Remove completed todos'),
              ),
            ],
          ),
        ],
      ),
      body: TodoList(
        todos: todos,
        onToggle: (todo) {
          setState(() {
            final index = todos.indexOf(todo);
            todos[index] = Todo(
              value: todo.value,
              completed: !todo.completed,
              due: todo.due,
              notes: todo.notes,
            );
          });
        },
        onLongPress: (todo) {
          setState(() {
            todos.remove(todo);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
