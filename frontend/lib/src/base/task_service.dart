import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:frontend/src/base/task.dart';
import 'package:http/http.dart';
//import 'package:frontend/src/base/mock_projects.dart';

@Injectable()
class TaskService {
//  Future<List<Project>> getProjects() async => mockProjects;
//  Future<Project> getProject(int id) async =>
//      (await getProjects()).firstWhere((project) => project.id == id);
  static const _authority = 'localhost:8080';
  static const _itemsPath = 'v1/projects';
  final Client _http;

  TaskService(this._http);

  Future<List<Task>> getTasks() async {
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
      (await getTasks()).firstWhere((task) => task.id == id);

  dynamic _extractData(Response response) => JSON.decode(response.body);

  Exception _handleError(dynamic e) {
    print(e);
    return new Exception('Server error; cause: $e');
  }
}