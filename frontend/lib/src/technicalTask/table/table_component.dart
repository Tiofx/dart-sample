import 'dart:async';
import 'dart:convert';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'package:angular_router/angular_router.dart';
import 'package:frontend/src/pageSelector/page_selector_component.dart';
import 'package:frontend/src/technicalTask/item/add/item_form_component.dart';

import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:frontend/src/technicalTask/item/item_component.dart';
import 'package:frontend/src/technicalTask/item/item_service.dart';


@Component(
    selector: 'technical-task-table',
    templateUrl: 'table_component.html',
    styleUrls: const ['table_component.css'],
    directives: const[
      CORE_DIRECTIVES,
      materialDirectives,
      ItemComponent,
      PageSelectorComponent,
      ItemFormComponent,
    ],
    providers: const [ItemService]
)

class TableComponent implements OnInit {
  Item item;
  final Router _router;
  final ItemService service;

  @Input()
  int pageNumber = 1;

  @Input()
  int perPage = 2;

  @Input()
  int offset = 0;

  List<Item> items = [];

  TableComponent(this.service, this._router);

  @override
  ngOnInit() async {
    updateItems();
  }

  changePage(int newPage) async {
    pageNumber = newPage;
    updateItems();
  }

  Future<Null> goAdd() => _router.navigate(['AddItem']);

//  addItem(Item item) async {
//    var newItem = await service.addItem(item);
//    print("new item: ${newItem.toString()}");
//
//    updateItems();
//  }

  Future<Null> goEditItem(Item item) => _router.navigate([
      'EditItem',
      {'id': item.number.toString()}
    ]);

  editItem(Item item) async {
    var result = await service.editItem(item);
    print(result);
    updateItems();
  }

  removeItem(int id) async {
    var result = await service.delete(id);
    print(result);

    updateItems();
  }

  updateItems() async {
    print("page_number:[$pageNumber], per_page:[$perPage], offset: [$offset]");
    items = await service
        .getItems(pageNumber, perPage, offset)
        .then((value) => value is Exception ? <Item>[] : value);

    items.map((item) => item.toJson())
        .forEach(print);
  }
}