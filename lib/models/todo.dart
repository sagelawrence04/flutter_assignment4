class Todo {
  final String value;
  late final bool completed;
  final DateTime? due;
  final String? notes;

  Todo({
    required this.value,
    this.completed = false,
    this.due,
    this.notes,
  });
}
