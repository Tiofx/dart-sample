import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:http/http.dart';

@Injectable()
class TableService {
  static const _authority = 'localhost:8080';
  static const _itemsPath = 'api/technical_task/items';
  final Client _http;

  TableService(this._http);

  Future<List<Item>> getItems(int pageNumber,
      int perPage,
      [int offset = 0]) async {
    try {
      final response = await _http.get(
//          '$_itemsUrl/?page=$pageNumber&per_page=$perPage&offset=$offset'
          new Uri.http(
              _authority,
              _itemsPath,
              {
                'page': '$pageNumber',
                'per_page': '$perPage',
                'offset': '$offset',
              }
          )
      );

      print(_extractData(response));

      final items = _extractData(response)
          .map((value) => new Item.fromJson(value))
          .toList();
      return items;
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response response) => JSON.decode(response.body);

  Exception _handleError(dynamic e) {
    print(e);
    return new Exception('Server error; cause: $e');
  }
}