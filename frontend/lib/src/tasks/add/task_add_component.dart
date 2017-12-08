import 'dart:async';

import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'package:frontend/src/base/task.dart';
import 'package:frontend/src/base/task_service.dart';
import 'package:http/http.dart';

@Component(
  selector: 'task-add',
  templateUrl: 'task_add_component.html',
  styleUrls: const ['task_add_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives],
)

class TaskAddComponent {
  Task task = new Task.empty();

  bool addTrue = false;
  static const _authority = 'localhost:8080';
  static const _basePath = 'v1/tasks';
  final TaskService _taskService;
  final Location _location;
  final _submit = new StreamController<Task>();
  final Client _http;

  TaskAddComponent(this._taskService,
      this._location,
      this._http);

  @Output("submitItem")
  Stream<Task> get submit => _submit.stream;

  onSubmit() =>
    _submit.add(task);

  Future<Task> addTask(Task task) async {
    print(task.toJson());
    _http.post(
        new Uri.http(
            _authority, _basePath
        ),
        body: JSON.encode(task?.toJson())
    )
        .then(_extractData)
        .catchError(_handleError)
        .then((body) => new Task.fromJson(body));

    addTrue=true;
  }
  void goBack() => _location.back();

  intRound(double number) => task.id = number.round();
  intRoundStg(double number) => task.stages_id = number.round();
  intRoundTTI(double number) => task.technical_task_item_id = number.round();
  intRoundDev(double number) => task.developer_id = number.round();

  goDelete(int recordId) async{
    var result = await _taskService.deleteTask(recordId);
  }

  dynamic _extractData(Response response) => JSON.decode(response.body);

  Exception _handleError(dynamic e) {
    print(e);
    return new Exception('Server error; cause: $e');
  }

//  clear() {
//    project.id = null;
//    project.author_id = null;
//    project.name = "";
//  }
}