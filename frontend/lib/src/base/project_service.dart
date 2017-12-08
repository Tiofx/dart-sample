import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:frontend/src/base/project.dart';
import 'package:http/http.dart';

@Injectable()
class ProjectService {
  static const _authority = 'localhost:8080';
  static const _itemsPath = 'v1/projects';
  final Client _http;

  ProjectService(this._http);

  Future<List<Project>> getProjects() async {
    try {
      final response = await _http.get(new Uri.http(
          _authority,
          _itemsPath,
      ));

      final heroes = _extractData(response)
          .map((value) => new Project.fromJson(value))
          .toList();
      return heroes;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Project> getProject(int id) async =>
      (await getProjects()).firstWhere((project) => project.id == id);

  Future<String> deleteProject(int recordId) async {
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