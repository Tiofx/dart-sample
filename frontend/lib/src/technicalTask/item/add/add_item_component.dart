import 'package:angular/angular.dart';
import 'package:angular/src/common/directives/core_directives.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/src/baseEntry/request_data.dart';
import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:angular_forms/src/directives/ng_form_model.dart';
import 'package:frontend/src/technicalTask/item/item_service.dart';
import 'package:frontend/src/technicalTask/itemStatus/item_status_component.dart';
import 'package:angular_forms/angular_forms.dart' as forms;

@Component(
    selector: 'add-item-component',
    templateUrl: 'add_item_component.html',
    directives: const[
      CORE_DIRECTIVES,
      ItemStatusComponent,
      forms.formDirectives,
    ],
    providers: const[ItemService]
)
class AddItemComponent {

  final item = new Item.empty();
  final ItemService _service;

  AddItemComponent(this._service);

  setUpNumber(double number) => item.number = number.round();

  onSubmit() {
    print(item.toJson());
    _service.addItem(item);
  }

  clear() {
    item.number = null;
    item.status = null;
    item.name = "";
    item.description = "";
  }
}