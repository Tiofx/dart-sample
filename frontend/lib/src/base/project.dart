class Project {
  final int id;
  final int author_id;
  String name;
  Project(this.id, this.author_id, this.name);

  factory Project.fromJson(Map<String, dynamic> json) =>
      new Project(
          _toInt(json['Id']),
          _toInt(json['AuthorId']['Id']),
          json['Name']);

}

int _toInt(raw) => raw is int ? raw : int.parse(raw);
