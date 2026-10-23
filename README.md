# Task List

A polished Flutter task manager for creating, organizing, and completing everyday tasks. The app keeps task data on the device, supports priorities and due dates, and provides a simple workflow for reviewing progress.

> **Project 4 — App Development Internship**
>
> Built with Flutter and Dart as an educational project. This repository contains the complete application, its tests, and a full-length walkthrough video.

## Full application demo

Watch the complete walkthrough of the app:

**[Watch the full Task List demo](20261022-2335-33.0347895.mp4)**

The video file is stored in the root of this repository. Select the link to open or download it from GitHub.

## Overview

Task List is a single-device task manager. It is designed to demonstrate common Flutter application patterns: reusable widgets, form validation, stateful screens, asynchronous operations, local persistence, and automated tests.

### Features

- Create tasks with a required title, priority, optional due date, and optional urgency level.
- Edit task details while preserving the task's completion state.
- Mark tasks complete or return them to the to-do list.
- Filter the list to show all, pending, or completed tasks.
- Sort tasks by priority or due date.
- Delete tasks only after confirmation, then restore them with **Undo**.
- See dedicated loading, empty, and error states.
- Keep tasks locally between app launches.
- Use English interface text and accessible controls.
- Enjoy subtle animations for completion and task interactions.

### Empty-state behavior

When there are no tasks to show, the app presents a clear empty state and an action to create the first task. The full walkthrough above demonstrates the app's screens and task flows.

## Getting started

### Requirements

- Flutter SDK compatible with the Dart SDK constraint in [`pubspec.yaml`](pubspec.yaml).
- Android Studio or Visual Studio Code with Flutter and Dart support.
- An Android emulator, iOS simulator (on macOS), or a connected device.

### Run locally

From the project directory, fetch dependencies, check available devices, and launch the app:

```sh
flutter pub get
flutter devices
flutter run
```

### Run quality checks

Run the automated test suite and Dart/Flutter static analysis:

```sh
flutter test
flutter analyze
```

## How the app is organized

```text
lib/
├── main.dart
├── app_theme.dart
├── exceptions/
│   └── task_exception.dart
├── models/
│   ├── basic_task.dart
│   ├── priority.dart
│   ├── task.dart
│   ├── task_factory.dart
│   └── urgent_task.dart
├── repositories/
│   ├── repository.dart
│   ├── shared_preferences_task_repository.dart
│   └── task_repository.dart
├── screens/
│   └── home_screen.dart
├── services/
│   └── task_service.dart
└── widgets/
    ├── task_card.dart
    └── task_editor_sheet.dart

test/
├── home_screen_test.dart
├── shared_preferences_task_repository_test.dart
├── task_model_test.dart
├── task_repository_test.dart
└── task_service_test.dart
```

Each layer has a focused responsibility:

| Area | Responsibility |
| --- | --- |
| `models/` | Defines task data, priority values, task subtypes, and JSON conversion. |
| `repositories/` | Defines the storage contract and implements local persistence. The Flutter app uses `SharedPreferencesTaskRepository`; the file-based `TaskRepository` is used by the console program and tests. |
| `services/` | Applies task rules such as validation, ID assignment, sorting, updates, and completion changes. |
| `screens/` | Coordinates screen state, loading, filtering, and user actions. |
| `widgets/` | Provides reusable task cards and the add/edit form. |
| `test/` | Verifies model, service, repository, and user-interface behavior. |

## A task's journey through the app

When a user adds or edits a task:

1. `TaskEditorSheet` collects the values and returns a `TaskDraft`.
2. `HomeScreen` sends the draft to `TaskService`.
3. `TaskService` validates the input and creates the appropriate task model.
4. `SharedPreferencesTaskRepository` converts the task to JSON and saves it locally.
5. When tasks are loaded again, `TaskFactory` uses the JSON `type` field to restore the correct model, including urgent tasks.

For example, a saved task is represented by data similar to:

```json
{
  "id": 1,
  "title": "Prepare the demo",
  "priority": "high",
  "dueDate": "2026-10-20T00:00:00.000",
  "completed": false,
  "type": "urgent",
  "urgencyLevel": 4
}
```

The JSON is stored under the `tasks` key in `shared_preferences`. This keeps the app simple and offline-capable; it does not create a user account or synchronize data between devices.

## Testing persistence

Automated persistence tests use a mocked preferences store. They verify that saved tasks can be read after the repository is recreated, but they do not simulate terminating and relaunching a real device process.

For a manual device check:

1. Run the app on an emulator or a physical device.
2. Add a task with a recognizable title.
3. Close the app completely.
4. Reopen it and confirm the task and its details are still present.
5. Repeat after editing, completing, and deleting a task.

## Privacy and security

- Task data is stored locally on the current device; this app does not provide cloud synchronization or an account system.
- `shared_preferences` is not encrypted storage. Do not use task titles or other fields to store passwords, authentication codes, financial information, or other sensitive data.
- Before publishing an Android release, configure a unique application ID and a private release signing key. Keep signing keys and passwords out of source control.
- Keep Flutter and package dependencies up to date.

## Technology

- Flutter and Dart
- Material 3
- `shared_preferences` for local persistence
- JSON for task serialization
- `flutter_test` and `package:test`

## Learning reference

The project brief references [dwyl's Flutter Todo List tutorial](https://github.com/dwyl/flutter-todo-list-tutorial). This project follows the same broad learning goal while using its own service-and-repository structure and on-device persistence implementation.

## Known limitations

- Tasks are kept on one device and are not backed up or synchronized.
- Preferences storage is intended for small amounts of app data. A local database such as SQLite or Drift is a better fit for larger datasets or stronger querying needs.
- The automated persistence tests use mocked storage; a real close-and-reopen check is recommended before presenting or publishing the app.
- Android release signing and the production application ID must be configured before store distribution.

## License

No license has been specified for this project. Contact the repository owner before redistributing or reusing the code.
