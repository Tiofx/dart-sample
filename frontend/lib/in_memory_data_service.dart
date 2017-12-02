import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:angular/angular.dart';
import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

@Injectable()
class InMemoryDataService extends MockClient {
  static final _initialTechnicalTaskItems = [
    {
      'id': 1,
      'name': 'Главная страница',
      'status': 'done',
      'last_change_date': '2002-02-27T19:00:00Z',
      'description': 'На странеце должна быть основная информации о компании----'
    },
    {
      'id': 2,
      'name': 'Контакты',
      'status': 'in_discussion',
      'last_change_date': '2017-11-13T00:00:00Z',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
    },
    {
      'id': 3,
      'name': 'Обслуживание',
      'status': 'in_work',
      'last_change_date': '2017-12-14T00:00:00Z',
      'description': 'Duis facilisis urna ut justo malesuada facilisis- '
    },
    {
      'id': 4,
      'name': 'Добавление новых заданий',
      'status': 'verify',
      'last_change_date': '2017-01-11T00:00:00Z',
      'description': 'Nam facilisis molestie enim sed molestie- Proin pellentesque augue a venenatis '
    },
    {
      'id': 5,
      'name': 'Главная страница',
      'status': 'done',
      'last_change_date': '2013-11-01T00:00:00Z',
      'description': 'Nulla accumsan risus in lobortis venenatis-'
    },
    {
      'id': 6,
      'name': 'Главная страница',
      'status': 'done',
      'last_change_date': '2017-11-12T00:00:00Z',
      'description': 'На странеце должна быть основная информации о компании----'
    },
    {
      'id': 7,
      'name': 'Контакты',
      'status': 'in_discussion',
      'last_change_date': '2017-11-13T00:00:00Z',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit'
    },
    {
      'id': 8,
      'name': 'Обслуживание',
      'status': 'in_work',
      'last_change_date': '2017-12-14T00:00:00Z',
      'description': 'Duis facilisis urna ut justo malesuada facilisis- '
    },
    {
      'id': 9,
      'name': 'Добавление новых заданий',
      'status': 'verify',
      'last_change_date': '2017-01-11T00:00:00Z',
      'description': 'Nam facilisis molestie enim sed molestie- Proin pellentesque augue a venenatis '
    },
    {
      'id': 10,
      'name': 'Главная страница',
      'status': 'done',
      'last_change_date': '2013-11-01T00:00:00Z',
      'description': 'Nulla accumsan risus in lobortis venenatis-'
    },

  ];
  static List<Item> _itemsDb;
  static int _nextId;

  static Future<Response> _handler(Request request) async {
    if (_itemsDb == null) resetDb();
    var data;
    switch (request.method) {
      case 'GET':
        var params = request.url.queryParameters;
        var page = int.parse(params['page']);
        var perPage = int.parse(params['per_page']);
        data = _itemsDb
            .skip(perPage * (page - 1))
            .take(perPage)
            .toList();
        break;
      case 'POST':
      case 'PUT':
      case 'DELETE':
        break;
      default:
        throw 'Unimplemented HTTP method ${request.method}';
    }

    return new Response(
      JSON.encode({'data': data}), 200,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );
  }

  static resetDb() {
    _itemsDb = _initialTechnicalTaskItems
        .map((json) => new Item.fromJson(json))
        .toList();
    _nextId = _itemsDb.map((item) => item.number).fold(0, max) + 1;
  }

  InMemoryDataService() :super(_handler);
}