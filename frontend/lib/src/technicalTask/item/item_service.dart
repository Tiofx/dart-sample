import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:http/http.dart';

@Injectable()
class ItemService {
  static const _authority = 'localhost:8080';
  static const _basePath = 'v1/technical_task_items';
  final Client _http;

  ItemService(this._http);

  Future<Item> addItem(Item item) async =>
      _http.post(
          new Uri.http(
              _authority, _basePath
          ),
          body: JSON.encode(item?.toJson())
      )
          .then(_extractData)
          .then((body) => new Item.fromJson(body))
//        .then((body) => print(body))
          .catchError(_handleError);

  dynamic _extractData(Response response) => JSON.decode(response.body);

  Exception _handleError(dynamic e) {
    print(e);
    return new Exception('Server error; cause: $e');
  }
}