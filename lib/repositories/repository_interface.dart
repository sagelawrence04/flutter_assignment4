import 'package:assignment_4/models/todo.dart';

/// This follows the repository pattern
abstract class ITodoRepository {
  List<Todo> getTodos();
}