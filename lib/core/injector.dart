import 'package:get_it/get_it.dart';

class Injector {
  Injector._();

  static T find<T extends Object>() {
    final getIt = GetIt.instance;
    return getIt.get<T>();
  }

  static void lazyPut<T extends Object>(T Function() callback) {
    GetIt.instance.registerLazySingleton<T>(callback);
  }

  static void put<T extends Object>(T object) {
    GetIt.instance.registerSingleton<T>(object);
  }

  static bool exists<T extends Object>() {
    return GetIt.I.isRegistered<T>();
  }
}
