import 'package:flutter/material.dart';
import 'views/todo_page.dart';

/// A simple TO-DO app for MAD512
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'todo app',
      home: TodoPage(),
    );
  }
}

