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
          .catchError(_handleError);

  dynamic _extractData(Response response) => JSON.decode(response.body);

  Future<List<Item>> getItems(int pageNumber,
      int perPage,
      [int offset = 0]) async =>
      _http.get(
          new Uri.http(
              _authority,
              _basePath,
              {
                'limit': '$perPage',
                'offset': '${calculateOffset(pageNumber, perPage, offset)}',
              }
          )
      )
          .then(_extractData)
          .then((body) =>
          body
              .map((value) => new Item.fromJson(value))
              .toList())
          .catchError(_handleError);

  Exception _handleError(dynamic e) {
    print(e);
    return new Exception('Server error; cause: $e');
  }
}

int calculateOffset(int pageNumber, int perPage, int offset) =>
    offset + perPage * (pageNumber - 1);