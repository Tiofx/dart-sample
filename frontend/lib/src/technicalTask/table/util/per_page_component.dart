import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/material_button/material_button.dart';
import 'package:frontend/src/technicalTask/item/item.dart';


@Component(
    selector: 'per-page-selector',
    template: '''
    <div>
    <span>Number of record on page: </span>
    <material-button clear-size 
                     *ngFor="let number of numbers"
                     (trigger)="currentNumber = number"
                     [disabled]="currentNumber == number">
        {{number}}
    </material-button>    
    </div>
''',
    directives: const[
      CORE_DIRECTIVES,
      MaterialButtonComponent,
    ]
)
class PerPageComponent {
  var _change = new StreamController<int>();
  int _currentNumber;

  @Input()
  List<int> numbers = [2, 5, 10];

  int get currentNumber => _currentNumber;

  @Input()
  set currentNumber(int number) {
    _currentNumber = number;
    _change.add(number);
  }

  @Output()
  Stream<int> get currentNumberChange => _change.stream;
}