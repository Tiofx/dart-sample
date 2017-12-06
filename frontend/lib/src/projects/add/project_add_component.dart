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

class ProjectAddComponent implements OnInit {
  @Input()
  Project project;

  final ProjectService _projectService;
  final RouteParams _routeParams;
  final Location _location;
  final Router _router;

  ProjectAddComponent(this._projectService,
      this._routeParams,
      this._location,
      this._router);

  Future<Null> ngOnInit() async {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null) project = await (_projectService.getProject(id));
  }

  onSubmit() {
    _submit.add(project);
  }

  final _submit = new StreamController<Project>();

  void goBack() => _location.back();

  goDelete(int recordId) async{
    print(recordId);
    var result = await _projectService.deleteProject(recordId);
    print(result);
  }

  void addNew(){}

}