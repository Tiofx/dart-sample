class Task {
  int id;
  int stages_id;
  int technical_task_item_id;
  int task_states_id;
  String name;
  String description;
  int developer_id;

  Task(this.id, this.stages_id, this.technical_task_item_id,
      this.task_states_id, this.name, this.description, this.developer_id);

  Task.empty();

  factory Task.fromJson(Map<String, dynamic> json) => new Task(
        _toInt(json['Id']),
        _toInt(json['StagesId']['Id']),
        _toInt(json['TechnicalTaskItemId']['Id']),
        1,
        json['Name'],
        json['Description'],
        _toInt(json['DeveloperId']['Id']),
      );

  Map toJson() =>
      {
        "Description": description,
        "DeveloperId": {
          "Id": developer_id
        },
        "Id": id,
        "Name": name,
        "StagesId": {
          "Id": stages_id
        },
        "TaskStatesId": {
          "Id": 1
        },
        "TechnicalTaskItemId": {
          "Id": technical_task_item_id
        }
      };

//        'Id': id,
//        'StagesId': {'Id': stages_id},
//        'TechnicalTaskItemId': {
//          'Id': technical_task_item_id,
//        },
//        'TaskStatesId': {'Id': 1},
//        'Name': name,
//        'Description': description,
//        'DeveloperId': {'Id': developer_id},
//      };
}

int _toInt(raw) => raw is int ? raw : int.parse(raw);
