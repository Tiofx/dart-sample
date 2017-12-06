import 'package:intl/intl.dart';

abstract class RequestData {
  RequestData.fromJson(Map<String, dynamic> json);

  Map toJson();

  static int toInt(raw) => raw is int ? raw : int.parse(raw);

//    2017-12-06T05:30:38.367446981+03:00
  static DateTime toDateTime(String raw) {
    var format = new DateFormat("yyyy-MM-ddTh:mm");
    return format.parse(raw);
  }
}