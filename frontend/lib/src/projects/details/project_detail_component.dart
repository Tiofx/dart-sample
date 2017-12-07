import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'package:frontend/src/base/project.dart';
import 'package:frontend/src/base/project_service.dart';

@Component(
  selector: 'project-detail',
  templateUrl: 'project_detail_component.html',
  styleUrls: const ['project_detail_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives],
)

class ProjectDetailComponent implements OnInit {
  Project project;
  bool deleteSuccessfull = false;
  final ProjectService _projectService;
  final RouteParams _routeParams;
  final Location _location;

  ProjectDetailComponent(this._projectService,
      this._routeParams,
      this._location);

  Future<Null> ngOnInit() async {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null) project = await (_projectService.getProject(id));
  }

  void goBack() => _location.back();

  goDelete(int recordId) async{
    var result = await _projectService.deleteProject(recordId);
    deleteSuccessfull = true;
  }
}