import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'package:frontend/src/base/task.dart';
import 'package:frontend/src/base/task_service.dart';

@Component(
  selector: 'task-detail',
  templateUrl: 'task_detail_component.html',
  styleUrls: const ['task_detail_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives],
)

class TaskDetailComponent implements OnInit {
  Task task;

  final TaskService _taskService;
  final RouteParams _routeParams;
  final Location _location;

  TaskDetailComponent(this._taskService, this._routeParams, this._location);

  Future<Null> ngOnInit() async {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null) task = await (_taskService.getTask(id));
  }

  void goBack() => _location.back();

}