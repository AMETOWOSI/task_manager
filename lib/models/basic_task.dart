import 'task.dart';
import 'package:task_manager/models/priority.dart';

class BasicTask extends Task {
  BasicTask(
    int id,
    String title,
    Priority priority,
    DateTime? dueDate,
    bool completed,
  ) : super(id, title, priority, dueDate, completed);

  BasicTask.fromJson(Map<String, dynamic> json)
    : super(
        json['id'] as int,
        json['title'] as String,
        Priority.values.firstWhere(
          (priority) => priority.name == json['priority'],
        ),
        json['dueDate'] != null
            ? DateTime.parse(json['dueDate'] as String)
            : null,
        json['completed'] as bool,
      );

  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'priority': priority.name,
    'dueDate': dueDate?.toIso8601String(),
    'completed': completed,
    'type': 'basic',
  };
}
