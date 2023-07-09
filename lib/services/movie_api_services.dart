import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/movie_detail_model.dart';
import 'package:toonflix/models/movie_model.dart';

class MovieApiService {
  static const String baseUrl = 'https://movies-api.nomadcoders.workers.dev/';
  static const String popular = 'popular';
  static const String now = 'now-playing';
  static const String coming = 'coming-soon';
  static const String detail = 'movie?id=';

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> popularMoviesInstances = [];
    final url = Uri.parse('$baseUrl$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final movies = result['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        popularMoviesInstances.add(instance);
      }
      return popularMoviesInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowPlayingMovies() async {
    List<MovieModel> nowPlayingMoviesInstances = [];
    final url = Uri.parse('$baseUrl$now');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final movies = result['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        nowPlayingMoviesInstances.add(instance);
      }
      return nowPlayingMoviesInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingSoonMovies() async {
    List<MovieModel> nowPlayingMoviesInstances = [];
    final url = Uri.parse('$baseUrl$coming');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final movies = result['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        nowPlayingMoviesInstances.add(instance);
      }
      return nowPlayingMoviesInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getDetailMovie(int id) async {
    final url = Uri.parse('$baseUrl$detail$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final instance = MovieDetailModel.fromJson(json);
      return instance;
    }
    throw Error();
  }
}
