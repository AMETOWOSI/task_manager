import 'package:task_manager/exceptions/task_exception.dart';
import 'package:task_manager/models/basic_task.dart';
import 'package:task_manager/models/priority.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/models/urgent_task.dart';
import 'package:task_manager/repositories/task_repository.dart';

class TaskService {
  final TaskRepository repository;

  TaskService(this.repository);

  Future<Task> addTask({
    required String title,
    required Priority priority,
    DateTime? dueDate,
    bool urgent = false,
    int urgencyLevel = 1,
  }) async {
    if (title.trim().isEmpty) {
      throw InvalidTaskException('Task title cannot be empty.');
    }

    final tasks = await repository.getAll();

    final nextId = tasks.isEmpty
        ? 1
        : tasks.map((task) => task.id).reduce((a, b) => a > b ? a : b) + 1;

    final Task task;

    if (urgent) {
      task = UrgentTask(
        nextId,
        title.trim(),
        priority,
        dueDate,
        false,
        urgencyLevel,
      );
    } else {
      task = BasicTask(nextId, title.trim(), priority, dueDate, false);
    }

    return repository.add(task);
  }

  Future<List<Task>> getTasks({String sortBy = 'priority'}) async {
    final tasks = await repository.getAll();

    if (sortBy == 'date') {
      tasks.sort((a, b) {
        if (a.dueDate == null && b.dueDate == null) {
          return 0;
        }

        if (a.dueDate == null) {
          return 1;
        }

        if (b.dueDate == null) {
          return -1;
        }

        return a.dueDate!.compareTo(b.dueDate!);
      });
    } else {
      tasks.sort(
        (a, b) =>
            _priorityValue(b.priority).compareTo(_priorityValue(a.priority)),
      );
    }

    return tasks;
  }

  Future<Task> completeTask(int id) async {
    final task = await repository.getById(id);

    task.completed = true;

    return repository.update(task);
  }

  Future<void> deleteTask(int id) async {
    await repository.delete(id);
  }

  int _priorityValue(Priority priority) {
    switch (priority) {
      case Priority.low:
        return 1;
      case Priority.medium:
        return 2;
      case Priority.high:
        return 3;
    }
  }
}
