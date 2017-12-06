import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:angular_forms/angular_forms.dart' as forms;
import 'package:frontend/src/technicalTask/itemStatus/item_status_component.dart';


@Component(
    selector: 'filter',
    templateUrl: 'filter_component.html',
    directives: const[
      CORE_DIRECTIVES,
      forms.formDirectives,
      ItemStatusComponent
    ]
)
class FilterComponent {
  static const _fields = const[
    "Id",
    "Name",
    "Date",
    "TechnikcaTaskStateId",
    "Description",
  ];
  StreamController _change = new StreamController();

  List get fields => _fields;

  var order = "asc";
  var sortby = "Id";

  String filterField;
  dynamic rawFilterValue;

  get filterValue => rawFilterValue;


  @Output()
  Stream get filterChange => _change.stream;

  @Output("init")
  Stream get init => new Stream.fromIterable([1]);

  change() {
    _change.add(null);
  }

  mapField(String field) {
    switch (field) {
      case "Id":
        return "Number";

      case "TechnikcaTaskStateId":
        return "State";

      default:
        return field;
    }
  }
}