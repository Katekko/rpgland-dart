import '../models/data.model.dart';

typedef Data = Map<String, dynamic>;

abstract class Store {
  String collection;

  Store({required this.collection});

  Future<List<T>> getAll<T extends DataModel>({
    required T Function(Map<String, dynamic>) mapper,
  });

  Future<void> save<T extends DataModel>(T data);

  Future<T?> getBy<T extends DataModel>({
    required String field,
    required value,
    required T Function(Map<String, dynamic>) mapper,
  });

  Future<void> saveAll(List<DataModel> data);
}
