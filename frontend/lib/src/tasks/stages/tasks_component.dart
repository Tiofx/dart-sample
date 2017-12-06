import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:frontend/src/base/task.dart';
import 'package:frontend/src/base/task_service.dart';


@Component(
  selector: 'my-tasks',
  templateUrl: 'tasks_component.html',
  styleUrls: const ['tasks_component.css'],
  directives: const [CORE_DIRECTIVES],
  pipes: const [COMMON_PIPES],
)

class TasksComponent implements OnInit {
  final TaskService _taskService;
  final Router _router;
  List<Task> tasks;
  Task selectedTask;

  TasksComponent(
      this._taskService,
      this._router
      );

  Future<Null> getTasks() async {
    tasks = await _taskService.getTasks();
  }

  void ngOnInit() => getTasks();

  void onSelect(Task hero) => selectedTask = hero;

  Future<Null> gotoDetail() => _router.navigate([
    'TaskDetail',
    {'id': selectedTask.id.toString()}
  ]);
}
