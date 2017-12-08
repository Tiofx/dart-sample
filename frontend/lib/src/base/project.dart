class Project {
  int id;
  int author_id;
  String name;
  Project(this.id, this.author_id, this.name);

  Project.empty();

  factory Project.fromJson(Map<String, dynamic> json) =>
      new Project(
          _toInt(json['Id']),
          _toInt(json['AuthorId']['Id']),
          json['Name']);

  Map toJson() =>
      {
        'Id': id,
        'AuthorId': {
          'Id': author_id
        },
        'Name': name,
      };
}

int _toInt(raw) => raw is int ? raw : int.parse(raw);
