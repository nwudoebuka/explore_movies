class FavoriteModel {
  FavoriteModel(
      {required this.averageRating,
      required this.imageUrl,
      required this.movieId,
      required this.year,
      required this.movieName});
  String movieId;
  String imageUrl;
  String averageRating;
  String year;
  String movieName;

  Map<String, dynamic> toJson() => {
        'movieId': movieId,
        'imageUrl': imageUrl,
        'averageRating': averageRating,
        'year': year,
        'movieName': movieName,
      };
}
