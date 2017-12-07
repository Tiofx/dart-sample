import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular/src/common/directives/core_directives.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/src/baseEntry/request_data.dart';

import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:http/http.dart';
import 'package:angular_forms/src/directives/ng_form_model.dart';
import 'package:frontend/src/technicalTask/item/item_service.dart';
import 'package:frontend/src/technicalTask/itemStatus/item_status_component.dart';
import 'package:angular_forms/angular_forms.dart' as forms;

@Component(
  selector: 'technical-task-item-form',
  templateUrl: 'item_form_component.html',
  styleUrls: const ['item_form_component.css'],
  directives: const[
    CORE_DIRECTIVES,
    ItemStatusComponent,
    forms.formDirectives,
  ],
)
class ItemFormComponent {
  final _submit = new StreamController<Item>();
  static const _authority = 'localhost:8080';
  static const _basePath = 'v1/technical_task_items';
  final Client _http;

  ItemFormComponent(this._http);

  @Input()
  bool isIdReadonly = false;

  @Input()
  String submitButtonName = "Add new";

  @Output("submitItem")
  Stream<Item> get submit => _submit.stream;

  @Input()
  Item item = new Item.empty();

  setUpNumber(double number) => item.number = number.round();

  onSubmit() {
    _submit.add(item);
  }

  Future<Item> addItem(Item item) async {
      _http.post(
          new Uri.http(
              _authority, _basePath
          ),
          body: JSON.encode(item?.toJson())
      )
          .then(_extractData)
          .then((body) => new Item.fromJson(body))
          .catchError(_handleError);
  }

  dynamic _extractData(Response response) => JSON.decode(response.body);

  Exception _handleError(dynamic e) {
    print(e);
    return new Exception('Server error; cause: $e');
  }

  clear() {
    item.number = null;
    item.status = null;
    item.name = "";
    item.description = "";
  }
}