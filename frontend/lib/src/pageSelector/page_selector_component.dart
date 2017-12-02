import 'dart:async';
import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

@Component(
  selector: 'page-selector',
  templateUrl: 'page_selector_component.html',
  directives: const[
    CORE_DIRECTIVES,
    materialDirectives,
  ],
)
class PageSelectorComponent {

  int _currentPage;

  int get currentPage => _currentPage;

  get pageNumberList =>
      new List<int>.generate(maxPage, (i) => i + 1);

  get middleListOfPage =>
      [currentPage - 1, currentPage, currentPage + 1]
          .where((page) => page > 1 && page < maxPage)
          .toList();

  @Input()
  set currentPage(int value) {
    _currentPage = value;
    _pageChange.add(value);
  }

  @Input()
  int maxPage;

  final _pageChange = new StreamController<int>();

  @Output()
  Stream<int> get pageChange => _pageChange.stream;

  bool get isFirstPage => currentPage == 1;

  bool get isLastPage => currentPage == maxPage;

  PageSelectorComponent();


  toFirstPage() => currentPage = 1;

  toLastPage() => currentPage = maxPage;

  toNextPage() {
    if (!isLastPage) currentPage++;
  }

  toPrevPage() {
    if (!isFirstPage) currentPage--;
  }

}
