import 'dart:async';

import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:frontend/src/technicalTask/item/item_service.dart';
import 'package:http/http.dart';

@Component(
  selector: 'edit-item',
  templateUrl: 'edit_item_component.html',
  styleUrls: const ['edit_item_component.css'],
  directives: const [CORE_DIRECTIVES, formDirectives],
)
class ItemEditComponent implements OnInit {
  Item item;

  final RouteParams _routeParams;
  final Location _location;
  static const _authority = 'localhost:8080';
  static const _basePath = 'v1/technical_task_items';
  final Client _http;

  ItemEditComponent(
      this._routeParams,
      this._location,
      this._http);

  Future<Null> ngOnInit() async {
    var _id = _routeParams.get('id');
    var id = int.parse(_id ?? '', onError: (_) => null);
    if (id != null)
//      item = await (_itemService.getOneItem(id));
      try {
        final response = await _http.get(new Uri.http(
          _authority,
          "$_basePath/$id",
        ));
        print(_extractData(response));

        item = new Item.fromJson(_extractData(response));

      } catch (e) {
        throw _handleError(e);
      }
  }

  dynamic _extractData(Response response) => JSON.decode(response.body);

  Exception _handleError(dynamic e) {
    print(e);
    return new Exception('Server error; cause: $e');
  }

  goBack() => _location.back();
}