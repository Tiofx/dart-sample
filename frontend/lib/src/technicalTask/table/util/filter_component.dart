import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:angular_forms/angular_forms.dart' as forms;

@Component(
    selector: 'filter',
    template: '''
    <div>
    <span>Filter: </span>
    
    <label>Order:</label>
    <select [(ngModel)]="order"
            (change)="change()">
    <option disabled value="">Select order</option>
    <option value="asc" selected>Ascending</option>
    <option value="desc">Descending</option>
    </select>
    
    <label>sortby:</label>
    <select [(ngModel)]="sortby"
            (change)="change()">
    <option disabled value="">Select field for sort</option>
    <option *ngFor="let field of fields"
            [value]="field"
            [selected]="field==sortby"
    >{{mapField(field)}}
    </option>
    
    </select>
    
    </div>
''',
    directives: const[
      CORE_DIRECTIVES,
      forms.formDirectives,
    ]
)
class FilterComponent {
  static const _fields = const[
    "Id",
    "Name",
    "Date",
    "TechnikcaTaskStateId",
  ];
  StreamController _change = new StreamController();

  get fields => _fields;

  var order = "asc";

  String sortby = "Id";

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