import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/src/pageSelector/page_selector_component.dart';
import 'package:frontend/src/technicalTask/item/item.dart';
import 'package:frontend/src/technicalTask/item/item_component.dart';
import 'package:frontend/src/technicalTask/table/table_service.dart';


@Component(
    selector: 'technical-task-table',
    templateUrl: 'table_component.html',
    directives: const[
      CORE_DIRECTIVES,
      materialDirectives,
      ItemComponent,
      PageSelectorComponent,
    ],
    providers: const [TableService]
)
class TableComponent implements OnInit {
  final TableService service;

  @Input()
  int pageNumber = 1;

  @Input()
  int perPage = 2;

  @Input()
  int offset = 0;

  List<Item> items = [];

  TableComponent(this.service);

  @override
  ngOnInit() async {
    updateItems();
  }

  changePage(int newPage) async {
    pageNumber = newPage;
    updateItems();
  }

  updateItems() async {
    items = await service.getItems(pageNumber, perPage, offset);
  }
}