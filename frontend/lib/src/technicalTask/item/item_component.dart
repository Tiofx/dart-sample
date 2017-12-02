import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/src/technicalTask/item/item.dart';


@Component(
    selector: 'technical-task-item',
    templateUrl: 'item_component.html',
    styleUrls: const ['item_component.css'],
    directives: const[CORE_DIRECTIVES]
)
class ItemComponent implements OnInit {
  @Input()
  Item item = new Item.empty();

//  final MenuModel<MenuItem> menuModel;


  @override
  ngOnInit() {
//    item
//      ..number = "${item.number} ___";

//    item
//      ..number = "1.1.1"
//      ..name = "Зделать этот чертовый компонент"
//      ..status = ItemStatus.inDiscussion
//      ..content = "Значит зделать так а потом так и еще вот так вот";
  }
}