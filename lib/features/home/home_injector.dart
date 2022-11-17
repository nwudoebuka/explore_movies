import 'package:explore/features/home/data/local/local_storage/export.dart';
import 'package:explore/features/home/data/remote/movie_remote_datasource.dart';
import 'package:explore/features/home/domain/service/movie_service.dart';
import 'package:explore/features/home/presentation/viewmodels/export.dart';
import 'package:explore/service_locator.dart';

class HomeInjector {
  static void register() {
    sl
      ..registerLazySingleton<MovieListDatasource>(
          () => MovieListDatasourceImpl(
                sl(),
              ))
      ..registerLazySingleton<MovieListService>(
        () => MovieListServiceImple(
          sl(),
        ),
      )
      ..registerLazySingleton<LocalStorage>(() => LocalStorageImpl())
      ..registerFactory(() => HomeViewModel(movieListService: sl()));
  }
}
