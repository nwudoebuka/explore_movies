import 'dart:developer';

import 'package:explore/core/network/export.dart';
import 'package:explore/features/home/data/local/local_storage/export.dart';
import 'package:explore/features/home/data/local/models/favorite_model.dart';
import 'package:explore/features/home/data/local/models/list_of_movies_model.dart';
import 'package:explore/features/home/data/local/models/movie_detail_dto.dart';
import 'package:explore/features/home/domain/service/movie_service.dart';
import 'package:explore/service_locator.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required this.movieListService}) {
    fetchFavoriteMovies();
  }

  MovieListService movieListService;

  ApiResult<MovieListModel> _listOfMovies = ApiResult.idle();
  ApiResult<MovieListModel> get listOfMovies => _listOfMovies;

  ApiResult<MovieDetailDto> _movieDetails = ApiResult.idle();
  ApiResult<MovieDetailDto> get movieDetails => _movieDetails;

  List<FavoriteModel> _listOfFavoriteMovies = [];
  List<FavoriteModel> get listOfFavoriteMovies => _listOfFavoriteMovies;

  bool _movieExists = false;
  bool get movieExists => _movieExists;

  Future<void> fetchMovieList() async {
    _listOfMovies = ApiResult.loading('loading');
    notifyListeners();

    final response = await movieListService.fetchMovieList();
    response.fold(
      (failure) {
        _listOfMovies = ApiResult.error(failure.message);
      },
      (data) {
        _listOfMovies = ApiResult.success(data);
      },
    );
    notifyListeners();
  }

  Future<void> fetchMovieDetails(String movieId) async {
    _movieExists = await sl<LocalStorage>().checkIfMovieExists(movieId);
    _movieDetails = ApiResult.loading('loading');
    notifyListeners();

    final response = await movieListService.fetchMovieDetails(movieId);
    response.fold((failure) {
      _movieDetails = ApiResult.error(failure.message);
    }, (data) {
      _movieDetails = ApiResult.success(data);
    });
    notifyListeners();
  }

  Future<void> fetchFavoriteMovies() async {
    final localStorage = sl<LocalStorage>();
    _listOfFavoriteMovies = await localStorage.fetchFavoriteMovies();
    log(_listOfFavoriteMovies.length.toString());
    notifyListeners();
  }

  void addToFavoriteList(FavoriteModel model) {
    _movieExists = !_movieExists;
    _listOfFavoriteMovies.add(model);
    notifyListeners();
  }

  void deleteFromFavoriteList(String movieId) {
    _movieExists = !_movieExists;
    _listOfFavoriteMovies.removeWhere((movie) {
      return movie.movieId == movieId;
    });
    notifyListeners();
  }
}
