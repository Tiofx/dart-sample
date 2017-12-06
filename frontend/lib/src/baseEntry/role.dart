import 'package:frontend/src/baseEntry/request_data.dart';

class Role implements RequestData {
  int id;
  String name;

  Role({this.id, this.name});

  @override
  factory Role.fromJson(Map<String, dynamic> json) =>
      new Role(
          id: RequestData.toInt(json['Id']),
          name: json['Name']
      );

  @override
  Map toJson() =>
      {
        'Id': id,
        'Name': name,
      };
}