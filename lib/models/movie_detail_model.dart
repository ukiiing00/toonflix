class MovieDetailModel {
  final String title, overview, poster_path;
  final double vote_average;
  final int runtime;
  final List<dynamic> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        poster_path = json['poster_path'],
        vote_average = json['vote_average'],
        runtime = json['runtime'],
        genres = json['genres'];
}
