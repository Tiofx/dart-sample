import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:frontend/src/base/project_service.dart';
import 'package:frontend/src/projects/add/project_add_component.dart';
import 'package:frontend/src/projects/dashboard_component.dart';
import 'package:frontend/src/projects/details/project_detail_component.dart';
import 'package:frontend/src/projects/stages/projects_component.dart';
import 'package:frontend/src/tasks/stages/tasks_component.dart';
import 'package:frontend/src/technicalTask/item/add/item_form_component.dart';
import 'package:frontend/src/technicalTask/item/edit/edit_item_component.dart';
import 'package:frontend/src/technicalTask/table/table_component.dart' as technical_task;

@Component(
  selector: 'my-app',
  template: '''
  <h1>{{title}}</h1>
  <nav>
    <a [routerLink]="['Dashboard']">Dashboard</a>
    <a [routerLink]="['Projects']">Projects</a>
    <a [routerLink]="['Discussion']">Discussion</a>
    <a [routerLink]="['Tasks']">Tasks</a>
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
  const Route(
    path: '/technical_task',
    name: 'Discussion',
    component: technical_task.TableComponent,
  ),
  const Route(
      path: '/projects', name: 'Projects', component: ProjectsComponent
  ),

  const Route(
    path: '/tasks', name: 'Tasks', component: TasksComponent
  ),

  const Route(
    path: '/addNewProject', name: 'AddNewProject', component: ProjectAddComponent
  ),

  const Route(
      path: '/editItem/:id', name: 'EditItem', component: ItemEditComponent
  ),

  const Route(
      path: '/addItem', name: 'AddItem', component: ItemFormComponent
  ),

])
class AppComponent {
  final title = 'Timetables';
}
