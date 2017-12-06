import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:frontend/src/base/project.dart';
import 'package:frontend/src/base/project_service.dart';



@Component(
  selector: 'my-dashboard',
  templateUrl: 'dashboard_component.html',
  styleUrls: const ['dashboard_component.css'],
  directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES],
)

class DashboardComponent implements OnInit {
  List<Project> projects;

  final ProjectService _projectService;

  DashboardComponent(this._projectService);

  Future<Null> ngOnInit() async {
    projects = (await _projectService.getProjects()).take(4).toList();
  }
}
