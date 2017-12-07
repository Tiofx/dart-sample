import 'dart:async';

import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'package:frontend/src/base/project.dart';
import 'package:frontend/src/base/project_service.dart';
import 'package:http/http.dart';

@Component(
  selector: 'project-add',
  templateUrl: 'project_add_component.html',
  styleUrls: const ['project_add_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives],
)

class ProjectAddComponent {
  Project project = new Project.empty();

  bool addTrue = false;
  static const _authority = 'localhost:8080';
  static const _basePath = 'v1/projects';
  final ProjectService _projectService;
  final Location _location;
  final _submit = new StreamController<Project>();
  final Client _http;

  ProjectAddComponent(this._projectService,
      this._location,
      this._http);

  @Output("submitItem")
  Stream<Project> get submit => _submit.stream;

  onSubmit() =>
    _submit.add(project);

  Future<Project> addProject(Project project) async {
    _http.post(
        new Uri.http(
            _authority, _basePath
        ),
        body: JSON.encode(project?.toJson())
    )
        .then(_extractData)
        .catchError(_handleError)
        .then((body) => new Project.fromJson(body));

    addTrue=true;
  }
  void goBack() => _location.back();

  intRound(double number) => project.id = number.round();
  intRoundAuth(double number) => project.author_id = number.round();

  goDelete(int recordId) async{
    var result = await _projectService.deleteProject(recordId);
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