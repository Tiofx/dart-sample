import 'dart:async';

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'todo_list_service.dart';

@Component(
  selector: 'todo-list',
  styleUrls: const ['todo_list_component.css'],
  templateUrl: 'todo_list_component.html',
  directives: const [
    CORE_DIRECTIVES,
    materialDirectives,
  ],
  providers: const [TodoListService],
)
class TodoListComponent implements OnInit {
  final TodoListService todoListService;

  List<String> items = [];
  String newTodo = '';

  TodoListComponent(this.todoListService);

  @override
  Future<Null> ngOnInit() async {
    items = await todoListService.getTodoList();
  }

  void add() {
    items.add(newTodo);
    newTodo = '';

    var path = 'http://localhost:8080/api/';
    var httpRequest = new HttpRequest();

    HttpRequest.getString(path).then((data) => print(data));

    HttpRequest.postFormData(path, {'data': 'data from dart'})
        .then((HttpRequest resp) {
      print(resp);
    });

//    httpRequest
//      ..open('GET', path)
////      ..setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
////      ..open('POST', path)
////      ..setRequestHeader("Access-Control-Allow-Origin", "*")
////      ..setRequestHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS")
////      ..setRequestHeader("Access-Control-Allow-Methods", "GET")
////      ..setRequestHeader("Content-Type", "text/plain")
//      ..send();
  }

  String remove(int index) => items.removeAt(index);

  void onReorder(ReorderEvent e) =>
      items.insert(e.destIndex, items.removeAt(e.sourceIndex));
}
