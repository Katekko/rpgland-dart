import './store.dart';

abstract class Service {
  Store store;
  Service(this.store);
}
