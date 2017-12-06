import 'dart:async';
import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:frontend/src/technicalTask/item/item.dart';


@Component(
    selector: 'item-status',
    template: '''
    <select class="form-group"
    #dropdown
    (change)="selectedStatus=dropdown.value">
      <option disabled selected value="">Select status</option>
      <option *ngFor="let status of values" [value]="status">{{mapToString(status)}}</option>
    </select>
''',
    directives: const[CORE_DIRECTIVES]
)
class ItemStatusComponent {

  ItemStatus _status;
  final _statusChange = new StreamController<ItemStatus>();

  ItemStatus get selectedStatus => _status;

  @Input()
  set selectedStatus(value) {
    if (value is String) {
      _status = parse(value);
    } else if (value is ItemStatus) {
      _status = value;
    } else {
      return;
    }

    _statusChange.add(_status);
  }

  @Output()
  Stream<ItemStatus> get selectedStatusChange => _statusChange.stream;

  List<ItemStatus> get values => ItemStatus.values;

  ItemStatus parse(String status) =>
      values.firstWhere((item) => item.toString() == status);

  String mapToString(ItemStatus status) {
    switch (status) {
      case ItemStatus.inDiscussion:
        return 'in discussion';

      case ItemStatus.inWork:
        return 'in work';

      case ItemStatus.verify:
        return 'verify';

      case ItemStatus.done:
        return 'done';

      default:
        throw 'Unsupported ItemStatus: [$status]';
    }
  }
}