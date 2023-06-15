abstract class DataModel<T> {
  final String id;
  const DataModel({required this.id});

  static T fromJson<T>(Map<String, dynamic> data) {
    throw UnimplementedError('fromData method must be implemented');
  }

  T toJson();
}
