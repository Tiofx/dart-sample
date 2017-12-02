import 'dart:convert';

class Item {
  int number;
  String name;
  ItemStatus status;

  DateTime lastChangeDate;
  String description;

  Item(this.number, this.name, this.status, this.lastChangeDate,
      this.description);

  factory Item.fromJson(Map<String, dynamic> json) =>
      new Item(
          _toInt(json['id']),
          json['name'],
          _toItemStatus(json['status']),
          DateTime.parse(json['last_change_date']),
          json['description']);

  Item.empty();

  Map toJson() =>
      {
        'id': number,
        'name': name,
        'status': _toJson(status),
        'last_change_date': lastChangeDate.toIso8601String(),
        'description': description,
      };
}

enum ItemStatus {
  inDiscussion,
  inWork,
  verify,
  done
}

int _toInt(raw) => raw is int ? raw : int.parse(raw);

DateTime _toDateTime(String raw) {

  return DateTime.parse(raw);
}

ItemStatus _toItemStatus(raw) {
  switch (raw) {
    case 'in_discussion':
      return ItemStatus.inDiscussion;

    case 'in_work':
      return ItemStatus.inWork;

    case 'verify':
      return ItemStatus.verify;

    case 'done':
      return ItemStatus.done;

    default:
      throw 'Unsupported item status: [$raw]';
  }
}

String _toJson(ItemStatus status) {
  switch (status) {
    case ItemStatus.inDiscussion:
      return 'in_discussion';

    case ItemStatus.inWork:
      return 'in_work';

    case ItemStatus.verify:
      return 'verify';

    case ItemStatus.done:
      return 'done';

    default:
      throw 'Unsupported ItemStatus: [$status]';
  }
}