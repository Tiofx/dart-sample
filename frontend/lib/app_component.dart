import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:frontend/src/technicalTask/table/table_component.dart' as TechnicalTask;
import 'src/todo_list/todo_list_component.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
  selector: 'my-app',
  styleUrls: const ['app_component.css'],
  templateUrl: 'app_component.html',
  directives: const [
    materialDirectives,
    TodoListComponent,
    TechnicalTask.TableComponent
  ],
  providers: const [materialProviders],
)
class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.
}
