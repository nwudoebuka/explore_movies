import 'package:explore/core/network/export.dart';
import 'package:explore/features/home/home_injector.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setUpLocator() async {
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(),
  );
  HomeInjector.register();
}
