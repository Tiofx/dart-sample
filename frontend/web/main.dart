import 'package:angular/angular.dart';
import 'package:frontend/in_memory_data_service.dart';
import 'package:http/http.dart';

import 'package:frontend/app_component.dart';
import 'package:http/browser_client.dart';
import 'package:frontend/src/technicalTask/item/item_component.dart';
import 'package:frontend/src/technicalTask/table/table_component.dart';

void main() {
  bootstrap(AppComponent,
      [
        provide(Client, useFactory: () => new BrowserClient(), deps: [])
//        provide(Client, useClass: InMemoryDataService)
      ]);
//  bootstrap(TableComponent);
}
