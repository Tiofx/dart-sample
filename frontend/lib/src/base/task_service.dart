import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:frontend/src/base/task.dart';
import 'package:http/http.dart';

@Injectable()
class TaskService {
  static const _authority = 'localhost:8080';
  static const _itemsPath = 'v1/tasks';
  final Client _http;

  TaskService(this._http);

  Future<List<Task>> getTaskes() async {
    try {
      final response = await _http.get(new Uri.http(
        _authority,
        _itemsPath,
      ));

      print(_extractData(response));

      final heroes = _extractData(response)
          .map((value) => new Task.fromJson(value))
          .toList();
      return heroes;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Task> getTask(int id) async =>
      (await getTaskes()).firstWhere((project) => project.id == id);

  Future<String> deleteTask(int recordId) async {
    _http.delete(new Uri.http(_authority, "$_itemsPath/$recordId"))
        .then(_extractData)
        .catchError(_handleError);
  }

  dynamic _extractData(Response response) => JSON.decode(response.body);

  Exception _handleError(dynamic e) {
    print(e);
    return new Exception('Server error; cause: $e');
  }
}