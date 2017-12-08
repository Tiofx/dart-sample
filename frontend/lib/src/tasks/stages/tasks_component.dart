import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:frontend/src/base/task.dart';
import 'package:frontend/src/base/task_service.dart';


@Component(
  selector: 'my-tasks',
  templateUrl: 'tasks_component.html',
  styleUrls: const ['tasks_component.css'],
  providers: const [TaskService],
  directives: const [CORE_DIRECTIVES],
  pipes: const [COMMON_PIPES],
)

class TasksComponent implements OnInit {
  bool deleteSuccessfull = false;
  final TaskService _taskService;
  final Router _router;
  List<Task> tasks;
  Task selectedTask;

  TasksComponent(
      this._taskService,
      this._router
      );

  Future<Null> getTasks() async {
    tasks = await _taskService.getTaskes();
  }

  void ngOnInit() { getTasks(); }

  void onSelect(Task task) => selectedTask = task;

  Future<Null> gotoDetail() => _router.navigate([
    'TaskDetail',
    {'id': selectedTask.id.toString()}
  ]);

  Future<Null> gotoAddNew() => _router.navigate([
    'AddTask',
  ]);

  goDelete(int recordId) async{
    var result = await _taskService.deleteTask(recordId);
    deleteSuccessfull = true;
  }
}
