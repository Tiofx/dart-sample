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
import 'package:frontend/src/technicalTask/itemStatus/item_status_component.dart';
import 'package:frontend/src/technicalTask/table/util/filter/filter_component.dart';
import 'package:frontend/src/technicalTask/table/util/per_page_component.dart';


@Component(
    selector: 'technical-task-table',
    templateUrl: 'table_component.html',
    styleUrls: const ['table_component.css'],
    directives: const[
      CORE_DIRECTIVES,
      materialDirectives,
      ItemComponent,
      PageSelectorComponent,
      PerPageComponent,
      ItemFormComponent,
      ItemStatusComponent,

      FilterComponent,
    ],
    providers: const [ItemService]
)
class TableComponent implements OnInit {
  Item item;
  final Router _router;

  int _recordNumber = 1;
  ItemStatus statusTest = ItemStatus.done;
  final ItemService service;

  @Input()
  int pageNumber = 1;

  @Input()
  int perPage = 2;

  @Input()
  int offset = 0;

  FilterComponent filter;

  int get maxPageNumber => (_recordNumber / perPage).ceil();

  List<Item> items = [];

  TableComponent(this.service, this._router);

  @override
  ngOnInit() async {
//    update();
  }

  changePage(int newPage, PageSelectorComponent page) async {
    pageNumber = newPage;
    await update();

    page.maxPage = maxPageNumber;
  }

  changePerPage(int value) async {
    perPage = value;
    await update();
  }

  Future<Null> goAdd() => _router.navigate(['AddItem']);

  Future<Null> goEditItem(Item item) => _router.navigate([
      'EditItem',
      {'id': item.number.toString()}
    ]);

  editItem(Item item) async {
    var result = await service.editItem(item);
    print(result);

    update();
  }

  removeItem(int id) async {
    var result = await service.delete(id);
    print(result);

    update();
  }

  update() async {
    updateItems();
    updateRecordNumber();
  }

  updateItems() async {
    String query = _formQuery;


    print("page_number:[$pageNumber], per_page:[$perPage], offset: [$offset]");
    print("query:[$query]");

    items = await service
        .getItems(pageNumber, perPage,
        query: query,
        offset: offset,
        order: filter?.order,
        sortby: filter?.sortby
    )
        .then((value) => value is Exception ? <Item>[] : value);

    items.map((item) => item.toJson())
        .forEach(print);
  }

  String get _formQuery {
    print(filter?.filterField);
    print(filter?.filterValue);

    var getKey = (String key) {
      switch (key) {
        case "Name":
        case "Description":
          return "${key}__startswith";
        default:
          return key;
      }
    };

    var isEmpty = filter?.filterField == null || filter?.filterField == "";

    var value = (filter?.rawFilterValue is ItemStatus)
        ? toId(filter?.rawFilterValue)
        : filter?.filterValue;

    var query =
    (isEmpty || filter?.filterValue == null) ? null
        : "${getKey(filter.filterField)}:$value";
    return query;
  }


  updateRecordNumber() async {
    _recordNumber = await service
        .count(query: _formQuery)
        .then((value) => value is int ? value : 1);
    print("_recordNumber: [$_recordNumber]");
    print("maxPageNumber: [$maxPageNumber]");
  }
}