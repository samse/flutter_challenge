class MovieDetailModel {
  final String poster_path;
  final String original_title;
  final List<dynamic> genres;
  final bool adult;
  final String overview;
  final num vote_average;

  MovieDetailModel({
    required this.poster_path,
    required this.original_title,
    required this.genres,
    required this.adult,
    required this.overview,
    required this.vote_average,
  });

  MovieDetailModel.fromJson({required Map<String, dynamic> json})
      : poster_path = json["poster_path"],
        original_title = json["original_title"],
        genres = json["genres"],
        adult = json["adult"],
        overview = json["overview"],
        vote_average = json["vote_average"];
}
