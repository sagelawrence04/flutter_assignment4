import 'package:assignment_4/models/todo.dart';
import 'repository_interface.dart';

/// implementation of the ITodoRepository
class TodoRepository extends ITodoRepository {

  @override
  List<Todo> getTodos() {
    return [
      Todo(
        value: "Do the laundry",
          completed: true
      ),
      Todo(
        value: "Do the dishes",
        completed: true
      ),
      Todo(
        value: "Take out trash",
        notes: "They pick it up on Tuesdays",
        due: DateTime(2022, 09, 20, 7)
      ),
      Todo(
        value: "Finish assignment 3",
        due: DateTime(2022, 09, 27, 4)
      ),
    ];
  }
}
