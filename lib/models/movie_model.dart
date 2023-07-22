class Movie {
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity; // Add null safety for double
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  String voteAverage; // Add null safety for double
  int? voteCount; // Add null safety for int

  Movie({
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity, // Add null safety for double
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage, // Add null safety for double
    this.voteCount, // Add null safety for int
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"], // Add null safety for double
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"], // Add null safety for double
      voteCount: json["vote_count"], // Add null safety for int
    );
  }
}

class SearchMovieModel {
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity; // Add null safety for double
  String posterPath;
  String releaseDate;
  String title;
  bool video;
  double voteAverage; // Add null safety for double
  int? voteCount; // Add null safety for int

  SearchMovieModel({
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity, // Add null safety for double
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage, // Add null safety for double
    this.voteCount, // Add null safety for int
  });

  factory SearchMovieModel.fromJson(Map<String, dynamic> json) {
    return SearchMovieModel(
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: json["popularity"], // Add null safety for double
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"], // Add null safety for double
      voteCount: json["vote_count"], // Add null safety for int
    );
  }
}
