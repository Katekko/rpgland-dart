import '../domain/abstractions/models/data.model.dart';
import '../domain/abstractions/service/store.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoStore extends Store {
  final Db db;
  MongoStore({required super.collection, required this.db});

  @override
  Future<List<T>> getAll<T extends DataModel>() async {
    final coll = db.collection(collection);
    final response = await coll.find().toList();
    final items = response.map(DataModel.fromJson<T>).toList();
    return items;
  }

  @override
  Future<void> save<T extends DataModel>(T data) async {
    final coll = db.collection(collection);
    await coll.insertOne(data.toJson());
  }

  @override
  Future<T?> getBy<T extends DataModel>(String field, value) async {
    final coll = db.collection(collection);
    final response = await coll.findOne(where.eq(field, value));
    if (response != null) {
      final item = DataModel.fromJson<T>(response);
      return item;
    }

    return null;
  }

  @override
  Future<void> saveAll(List<DataModel> data) async {
    // TODO: implement saveAll
    throw UnimplementedError();
  }
}
