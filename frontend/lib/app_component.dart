import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:frontend/src/base/project_service.dart';
import 'package:frontend/src/projects/dashboard_component.dart';
import 'package:frontend/src/projects/details/project_detail_component.dart';
import 'package:frontend/src/projects/stages/projects_component.dart';

@Component(
  selector: 'my-app',
  template: '''
  <h1>{{title}}</h1>
  <nav>
    <a [routerLink]="['Dashboard']">Dashboard</a>
    <a [routerLink]="['Projects']">Projects</a>
  </nav>
  <router-outlet></router-outlet>
''',

  styleUrls: const ['app_component.css'],
  directives: const [ROUTER_DIRECTIVES],
  providers: const [ProjectService],
)

@RouteConfig(const [
  const Redirect(path: '/', redirectTo: const ['Dashboard']),
  const Route(
    path: '/dashboard',
    name: 'Dashboard',
    component: DashboardComponent,
  ),
  const Route(
    path: '/detail/:id',
    name: 'ProjectDetail',
    component: ProjectDetailComponent,
  ),
  const Route(path: '/projects', name: 'Projects', component: ProjectsComponent),
])

class AppComponent {
  final title = 'Timetables';
}
