import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix2/models/webtoon_detail.dart';
import 'package:toonflix2/models/webtoon_episode.dart';
import 'package:toonflix2/models/webtoon_model.dart';

import '../models/movie_detail.dart';
import '../models/movie_model.dart';

class ApiServices {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String movieBaseUrl =
      "https://movies-api.nomadcoders.workers.dev";

  static const String popular = "popular";
  static const String nowPlaying = "now-playing";
  static const String commingSoon = "coming-soon";
  static const String detail = "movie?id=";
  static const String today = "today";

  static Future<MovieDetailModel> fetchMovieDetail(String movieId) async {
    var url = Uri.parse('$movieBaseUrl/$detail$movieId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> results = jsonDecode(response.body);
      MovieDetailModel model = MovieDetailModel.fromJson(json: results);
      return model;
    }
    throw Error();
  }

  static Future<List<MovieModel>> fetchPopularMovies() async {
    List<MovieModel> movieInstances = [];
    var url = Uri.parse('$movieBaseUrl/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> results = jsonDecode(response.body);
      final List<dynamic> movies = results["results"];
      for (var movie in movies) {
        final model = MovieModel.fromJson(movie);
        print("Movie title : ${model.title}, ${model.id}");
        movieInstances.add(model);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> fetchNowPlayingMovies() async {
    List<MovieModel> movieInstances = [];
    var url = Uri.parse('$movieBaseUrl/$nowPlaying');
    // print("url: $url");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print("response : ${response.body}");
      final Map<String, dynamic> results = jsonDecode(response.body);
      final List<dynamic> movies = results["results"];
      for (var movie in movies) {
        final model = MovieModel.fromJson(movie);
        print("NowPlaying Movie title : ${model.title}");
        movieInstances.add(model);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> fetchComingSoonMovies() async {
    List<MovieModel> movieInstances = [];
    var url = Uri.parse('$movieBaseUrl/$commingSoon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> results = jsonDecode(response.body);
      final List<dynamic> movies = results["results"];
      for (var movie in movies) {
        final model = MovieModel.fromJson(movie);
        print("Comming Soon Movie title : ${model.title}");
        movieInstances.add(model);
      }
      return movieInstances;
    }
    return movieInstances;
    // throw Error();
  }

  static Future<Map<String, List<MovieModel>>> fetchAllMovies() async {
    List<MovieModel> popular = await fetchPopularMovies();
    List<MovieModel> nowPlaying = await fetchNowPlayingMovies();
    List<MovieModel> comingSoon = await fetchComingSoonMovies();

    return {
      "popular": popular,
      "nowPlaying": nowPlaying,
      "comingSoon": comingSoon,
    };
  }

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    var url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final model = WebtoonModel.fromJson(webtoon);
        print(model.title);
        webtoonInstances.add(model);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetail> getDetails(String id) async {
    var url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetail.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisode>> getEpisode(String id) async {
    List<WebtoonEpisode> episodeInstances = [];
    var url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        final model = WebtoonEpisode.fromJson(episode);
        episodeInstances.add(model);
      }
      return episodeInstances;
    }
    throw Error();
  }
}
