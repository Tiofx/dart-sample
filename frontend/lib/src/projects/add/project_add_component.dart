import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'package:frontend/src/base/project.dart';
import 'package:frontend/src/base/project_service.dart';

@Component(
  selector: 'project-add',
  templateUrl: 'project_add_component.html',
  styleUrls: const ['project_add_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives],
)

class ProjectAddComponent {
  Project project;

  final ProjectService _projectService;
  final Location _location;
  final _submit = new StreamController<Project>();

  ProjectAddComponent(this._projectService, this._location);

  @Output("submitItem")
  Stream<Project> get submit => _submit.stream;

  onSubmit() {
    print("asda");
    _submit.add(project);
    print("aaaaaa");
  }

  void goBack() => _location.back();

  goDelete(int recordId) async{
    print(recordId);
    var result = await _projectService.deleteProject(recordId);
    print(result);
  }

  void addNew(){}

//  clear() {
//    project.id = null;
//    project.author_id = null;
//    project.name = "";
//  }
}