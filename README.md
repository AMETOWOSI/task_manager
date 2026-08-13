# Task Manager CLI

A command-line task management application built with pure Dart.

This project was developed as part of a Dart certification project.

## Features

- Add tasks
- Set task priority:
  - Low
  - Medium
  - High
- Add an optional due date
- Create urgent tasks with an urgency level
- List all tasks
- Sort tasks by priority or due date
- Mark tasks as completed
- Delete tasks
- Persist tasks in a local JSON file
- Handle errors with custom exceptions
- Unit tests with the Dart `test` package

## Technologies

- Dart
- Dart CLI
- JSON
- `dart:io`
- `dart:convert`
- `package:test`

## Project Architecture

```text
lib/
├── exceptions/
│   └── task_exception.dart
│
├── models/
│   ├── basic_task.dart
│   ├── priority.dart
│   ├── task.dart
│   ├── task_factory.dart
│   └── urgent_task.dart
│
├── repositories/
│   ├── repository.dart
│   └── task_repository.dart
│
└── services/
    └── task_service.dart

bin/
└── task_manager.dart

test/
├── task_model_test.dart
├── task_repository_test.dart
└── task_service_test.dart

data/
└── tasks.json