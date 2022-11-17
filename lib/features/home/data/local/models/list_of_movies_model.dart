class MovieListModel {
  String? createdBy;
  String? description;
  int? favoriteCount;
  String? id;
  List<MovieList>? items;
  int? itemCount;
  String? iso6391;
  String? name;
  String? posterPath;

  MovieListModel(
      {this.createdBy,
      this.description,
      this.favoriteCount,
      this.id,
      this.items,
      this.itemCount,
      this.iso6391,
      this.name,
      this.posterPath});

  MovieListModel.fromJson(Map<String, dynamic> json) {
    createdBy = json['created_by'];
    description = json['description'];
    favoriteCount = json['favorite_count'];
    id = json['id'];
    if (json['items'] != null) {
      items = <MovieList>[];
      json['items'].forEach((v) {
        items!.add(MovieList.fromJson(v));
      });
    }
    itemCount = json['item_count'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
    posterPath = json['poster_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['created_by'] = createdBy;
    data['description'] = description;
    data['favorite_count'] = favoriteCount;
    data['id'] = id;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['item_count'] = itemCount;
    data['iso_639_1'] = iso6391;
    data['name'] = name;
    data['poster_path'] = posterPath;
    return data;
  }
}

class MovieList {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? mediaType;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  int? voteCount;
  double? voteAverage;

  MovieList({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.mediaType,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteCount,
    this.voteAverage,
  });

  MovieList.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    mediaType = json['media_type'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['video'];
    voteCount = json['vote_count'];
    if (json['vote_average'] is int) {
      voteAverage = (json['vote_average'] as int).toDouble();
    } else {
      voteAverage = json['vote_average'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['media_type'] = mediaType;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_count'] = voteCount;
    data['vote_average'] = voteAverage;
    return data;
  }

  MovieList copyWith(
    int? id,
    String? originalTitle,
    String? posterPath,
    String? releaseDate,
    double? voteAverage,
  ) {
    return MovieList(
      id: id,
      originalTitle: originalTitle,
      posterPath: posterPath,
      releaseDate: releaseDate,
      voteAverage: voteAverage,
    );
  }

  String get fullImagePath => 'https://image.tmdb.org/t/p/w500$posterPath';
}
