abstract class RequestData {
  RequestData.fromJson(Map<String, dynamic> json);

  Map toJson();

  static int toInt(raw) => raw is int ? raw : int.parse(raw);

  static DateTime toDateTime(String raw) {
    return DateTime.parse(raw);
  }
}