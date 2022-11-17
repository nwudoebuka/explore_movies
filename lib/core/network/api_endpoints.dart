import 'package:explore/core/utils/export.dart';

final baseUrl = AppConfig.baseUrl;
final apiKey = AppConfig.apiKey;

class _MovieEndpoints {
  final fetchMovieList = '$baseUrl/list/1?api_key=$apiKey=en-US';
  String fetchMovieDetails(String movieId) =>
      '$baseUrl/movie/102899?api_key=$apiKey&language=en-US';
}

// endpoints
final movieEndpoint = _MovieEndpoints();
