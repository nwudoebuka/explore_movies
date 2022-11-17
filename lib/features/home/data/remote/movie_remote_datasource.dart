import 'package:dartz/dartz.dart';
import 'package:explore/core/network/api_client.dart';
import 'package:explore/core/network/api_endpoints.dart';
import 'package:explore/core/utils/export.dart';
import 'package:explore/features/home/data/local/models/list_of_movies_model.dart';
import 'package:explore/features/home/data/local/models/movie_detail_dto.dart';

abstract class MovieListDatasource {
  Future<Either<ApiFailure, MovieListModel>> fetchMovieList();
  Future<Either<ApiFailure, MovieDetailDto>> fetchMovieDetails(String movieId);
}

class MovieListDatasourceImpl implements MovieListDatasource {
  MovieListDatasourceImpl(this.apiClient);
  ApiClient apiClient;
  @override
  Future<Either<ApiFailure, MovieListModel>> fetchMovieList() async {
    try {
      final response = await apiClient.get(movieEndpoint.fetchMovieList);
      return Right(MovieListModel.fromJson(response.data));
    } on ApiException catch (err) {
      return Left(
        ApiFailure(message: err.message),
      );
    }
  }
  
  @override
  Future<Either<ApiFailure, MovieDetailDto>> fetchMovieDetails(String movieId) async {
    try {
      final response = await apiClient.get(movieEndpoint.fetchMovieDetails(movieId));
      return Right(MovieDetailDto.fromJson(response.data));
    } on ApiException catch (err) {
      return Left(
        ApiFailure(message: err.message),
      );
    }
  }
}
