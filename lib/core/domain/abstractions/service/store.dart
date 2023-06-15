import '../models/data.model.dart';

typedef Data = Map<String, dynamic>;

abstract class Store {
  String collection;

  Store({required this.collection});

  Future<List<T>> getAll<T extends DataModel>();

  Future<void> save<T extends DataModel>(T data);

  Future<T?> getBy<T extends DataModel>(String field, dynamic value);

  Future<void> saveAll(List<DataModel> data);
}
