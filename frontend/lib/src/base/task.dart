class Task {
  final int id;
  final int stages_id;
  final int technical_task_item_id;
  final int task_states_id;
  String name;
  String description;
  final int developer_id;

  Task(this.id,
      this.stages_id,
      this.technical_task_item_id,
      this.task_states_id,
      this.name,
      this.description,
      this.developer_id
      );

  factory Task.fromJson(Map<String, dynamic> json) =>
      new Task(
          _toInt(json['Id']),
          _toInt(json['StagesId']['Id']),
          _toInt(json['TechnicalTaskItemId']),
          _toInt(json['TaskStatesId']),
          json['Name'],
          json['Description'],
          _toInt(json['DeveloperId']),
      );
}

int _toInt(raw) => raw is int ? raw : int.parse(raw);
