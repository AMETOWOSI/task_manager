import 'package:task_manager/models/priority.dart';

abstract class Task {
  final int id; //ne peut pas être réassigné
  String title;
  Priority priority;
  DateTime? dueDate;
  bool completed;

  Task(this.id, this.title, this.priority, this.dueDate, this.completed);

  Map<String, dynamic> toJson();
}
