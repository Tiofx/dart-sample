import 'package:frontend/src/baseEntry/request_data.dart';
import 'package:frontend/src/baseEntry/role.dart';

class User implements RequestData {
  int id;
  String login;
  String password;
  Role role;

  User({this.id, this.login, this.password, this.role});

  factory User.fromJson(Map<String, dynamic> json)=>
      new User(
          id: RequestData.toInt(json['Id']),
          login: json['Login'],
          password: json['Password'],
          role: new Role.fromJson(json['RoleId'])
      );

  @override
  Map toJson() =>
      {
        'Id': id,
        'Login': login,
        'Password': password,
        'RoleId': role?.toJson()
      };
}