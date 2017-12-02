import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:frontend/app_component.dart';
//import 'package:angular2/router.dart'
//    show
//    HashLocationStrategy,
//    LocationStrategy,
//    ROUTER_PROVIDERS;

import 'package:frontend/app_component.dart';

void main() {
  bootstrap(AppComponent, [
    ROUTER_PROVIDERS,
    // Remove next line in production
    provide(LocationStrategy, useClass: HashLocationStrategy),
  ]);
}
