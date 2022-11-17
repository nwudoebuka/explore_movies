import 'package:dartz/dartz.dart';
import 'package:explore/core/utils/export.dart';
import 'package:explore/features/home/data/local/models/export.dart';
import 'package:explore/features/home/data/remote/movie_remote_datasource.dart';

abstract class MovieListService {
  Future<Either<ApiFailure, MovieListModel>> fetchMovieList();
  Future<Either<ApiFailure, MovieDetailDto>> fetchMovieDetails(String movieId);
}

class MovieListServiceImple implements MovieListService {
  MovieListServiceImple(this.movieListDatasource);
  MovieListDatasource movieListDatasource;
  @override
  Future<Either<ApiFailure, MovieListModel>> fetchMovieList() {
    return movieListDatasource.fetchMovieList();
  }

  @override
  Future<Either<ApiFailure, MovieDetailDto>> fetchMovieDetails(String movieId) {
    return movieListDatasource.fetchMovieDetails(movieId);
  }
}
