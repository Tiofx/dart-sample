import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:frontend/src/base/project.dart';
import 'package:frontend/src/base/project_service.dart';


@Component(
  selector: 'my-projects',
  templateUrl: 'projects_component.html',
  styleUrls: const ['projects_component.css'],
  directives: const [CORE_DIRECTIVES],
  pipes: const [COMMON_PIPES],
)

class ProjectsComponent implements OnInit {
  final ProjectService _projectService;
  final Router _router;
  List<Project> projects;
  Project selectedProject;

  ProjectsComponent(
      this._projectService,
      this._router
      );

  Future<Null> getProjects() async {
    projects = await _projectService.getProjects();
  }

  void ngOnInit() => getProjects();

  void onSelect(Project hero) => selectedProject = hero;

  Future<Null> gotoDetail() => _router.navigate([
    'ProjectDetail',
    {'id': selectedProject.id.toString()}
  ]);

  Future<Null> gotoAddNew() => _router.navigate([
    'AddNewProject',
    ]);
}
