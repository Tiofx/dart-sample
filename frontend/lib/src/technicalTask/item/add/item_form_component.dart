import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular/src/common/directives/core_directives.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/src/baseEntry/request_data.dart';
import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:angular_forms/src/directives/ng_form_model.dart';
import 'package:frontend/src/technicalTask/item/item_service.dart';
import 'package:angular_forms/angular_forms.dart' as forms;
import 'package:frontend/src/technicalTask/itemStatus/item_status_component.dart';

@Component(
  selector: 'technical-task-item-form',
  templateUrl: 'item_form_component.html',
  directives: const[
    CORE_DIRECTIVES,
    forms.formDirectives,
    ItemStatusComponent,
  ],
)
class ItemFormComponent {

  final _submit = new StreamController<Item>();

  @Input()
  bool isIdReadonly = false;

  @Input()
  String submitButtonName = "";

  @Output("submitItem")
  Stream<Item> get submit => _submit.stream;

  @Input()
  Item item = new Item.empty();

  setUpNumber(double number) => item.number = number.round();

  onSubmit() {
    _submit.add(item);
  }

  clear() {
    item.number = null;
    item.status = null;
    item.name = "";
    item.description = "";
  }
}