import 'package:frontend/src/baseEntry/user.dart';
import 'package:frontend/src/baseEntry/request_data.dart';

class Item implements RequestData {
  int number;
  User author;
  String name;
  ItemStatus status;

  DateTime lastChangeDate;
  String description;

  Item({this.number, this.author, this.name, this.status, this.lastChangeDate,
    this.description});


  factory Item.fromJson(Map<String, dynamic> json) =>
      new Item(
          number: RequestData.toInt(json['Id']),
          name: json['Name'],
          status: toItemStatus(json['TechnikcaTaskStateId']['Id']),
          lastChangeDate: RequestData.toDateTime(json['Date']),
          description: json['Description']);

  Item.empty();

  Map toJson() =>
      {
        'AuthorId': author?.toJson() ?? new User(id: 1).toJson(),
//        'Date': lastChangeDate?.toString(),
        'Description': description,
        'Id': number,
        'Name': name,
        'TechnikcaTaskStateId': _toJson(status),
      };
}

enum ItemStatus {
  inDiscussion,
  inWork,
  verify,
  done
}


ItemStatus toItemStatus(raw) {
  if (raw is int) return ItemStatus.values[raw - 1];
  switch (raw) {
    case 'in_discussion':
    case 'in discussion':
      return ItemStatus.inDiscussion;

    case 'in_work':
    case 'in work':
      return ItemStatus.inWork;

    case 'verify':
      return ItemStatus.verify;

    case 'done':
      return ItemStatus.done;

    default:
      throw 'Unsupported item status: [$raw]';
  }
}

Map _toJson(ItemStatus status) =>
    {
      "Id": toId(status),
      "Name": _toString(status),
    };

int toId(ItemStatus status) => status.index + 1;


String _toString(ItemStatus status) {
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