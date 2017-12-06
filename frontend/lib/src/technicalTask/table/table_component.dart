import 'dart:convert';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/src/baseEntry/user.dart';
import 'package:frontend/src/pageSelector/page_selector_component.dart';
import 'package:frontend/src/technicalTask/item/add/item_form_component.dart';
import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:frontend/src/technicalTask/item/item_component.dart';
import 'package:frontend/src/technicalTask/item/item_service.dart';
import 'package:frontend/src/technicalTask/table/util/per_page_component.dart';


@Component(
    selector: 'technical-task-table',
    templateUrl: 'table_component.html',
    directives: const[
      CORE_DIRECTIVES,
      materialDirectives,
      ItemComponent,
      PageSelectorComponent,
      PerPageComponent,
      ItemFormComponent,
    ],
    providers: const [ItemService]
)
class TableComponent implements OnInit {
  int _recordNumber = 1;
  final ItemService service;

  @Input()
  int pageNumber = 1;

  @Input()
  int perPage = 2;

  @Input()
  int offset = 0;

  int get maxPageNumber => (_recordNumber / perPage).ceil();

  List<Item> items = [];

  TableComponent(this.service);

  @override
  ngOnInit() async {
    update();
  }

  changePage(int newPage) async {
    pageNumber = newPage;
    update();
  }

  changePerPage(int value) async {
    perPage = value;
    update();
  }

  addItem(Item item) async {
    var newItem = await service.addItem(item);
    print("new item: ${newItem.toString()}");

    update();
  }

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
    print("page_number:[$pageNumber], per_page:[$perPage], offset: [$offset]");
    items = await service
        .getItems(pageNumber, perPage, offset)
        .then((value) => value is Exception ? <Item>[] : value);

    items.map((item) => item.toJson())
        .forEach(print);
  }

  updateRecordNumber() async {
    _recordNumber = await service.count();
  }
}