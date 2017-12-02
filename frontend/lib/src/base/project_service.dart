import 'package:angular/angular.dart';
import 'package:frontend/src/base/project.dart';
import 'package:frontend/src/base/mock_projects.dart';
import 'dart:async';

@Injectable()
class ProjectService {
  Future<List<Project>> getProjects() async => mockProjects;
  Future<Project> getProject(int id) async =>
      (await getProjects()).firstWhere((project) => project.id == id);
}