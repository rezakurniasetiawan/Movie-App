import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/constants.dart';

import '../models/movie_model.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var movies = <Movie>[].obs;
  var currentMovieIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final response =
          await http.get(Uri.parse('$baseURL/movie/popular?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<Movie> movieList = [];
        for (var item in jsonData['results']) {
          movieList.add(Movie(
            id: item['id'],
            title: item['title'],
            overview: item['overview'],
            posterPath: 'https://image.tmdb.org/t/p/w500${item['poster_path']}',
            originalLanguage: item['original_language'],
            originalTitle: item['original_title'],
            popularity: item['popularity'],
            releaseDate: item['release_date'],
            video: item['video'],
            voteAverage: item['vote_average'].toString(),
            voteCount: item['vote_count'],
          ));
        }
        movies.assignAll(movieList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}

class RecomendationMovieController extends GetxController {
  var isLoading = true.obs;
  var movies = <Movie>[].obs;
  var currentMovieIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final response = await http
          .get(Uri.parse('$baseURL/movie/300/recommendations?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<Movie> movieList = [];
        for (var item in jsonData['results']) {
          movieList.add(Movie(
            id: item['id'],
            title: item['title'],
            overview: item['overview'],
            posterPath: 'https://image.tmdb.org/t/p/w500${item['poster_path']}',
            originalLanguage: item['original_language'],
            originalTitle: item['original_title'],
            popularity: item['popularity'],
            releaseDate: item['release_date'],
            video: item['video'],
            voteAverage: item['vote_average'].toString(),
            voteCount: item['vote_count'],
          ));
        }
        movies.assignAll(movieList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}

class NowPlayingMovieController extends GetxController {
  var isLoading = true.obs;
  var movies = <Movie>[].obs;
  var currentMovieIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final response = await http
          .get(Uri.parse('$baseURL/movie/now_playing?api_key=$apiKey'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<Movie> movieList = [];
        for (var item in jsonData['results']) {
          movieList.add(Movie(
            id: item['id'],
            title: item['title'],
            overview: item['overview'],
            posterPath: 'https://image.tmdb.org/t/p/w500${item['poster_path']}',
            originalLanguage: item['original_language'],
            originalTitle: item['original_title'],
            popularity: item['popularity'],
            releaseDate: item['release_date'],
            video: item['video'],
            voteAverage: item['vote_average'].toString(),
            voteCount: item['vote_count'],
          ));
        }
        movies.assignAll(movieList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}

class SearchMovie extends GetxController {
  var isLoading = true.obs;
  var movies = <SearchMovieModel>[].obs;
  var currentMovieIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMovies(''); // Initialize with an empty query initially
  }

  Future<void> fetchMovies(String query) async {
    try {
      // Encode the query parameter to handle special characters
      final encodedQuery = Uri.encodeQueryComponent(query);
      final response = await http.get(
        Uri.parse('$baseURL/search/movie?query=$encodedQuery&api_key=$apiKey'),
      );
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List<SearchMovieModel> movieList = [];
        for (var item in jsonData['results']) {
          movieList.add(SearchMovieModel(
            id: item['id'],
            title: item['title'],
            overview: item['overview'],
            posterPath: 'https://image.tmdb.org/t/p/w500${item['poster_path']}',
            originalLanguage: item['original_language'],
            originalTitle: item['original_title'],
            popularity: item['popularity'],
            releaseDate: item['release_date'],
            video: item['video'],
            voteAverage: item['vote_average']
                .toDouble(), // Assuming vote_average is a double
            voteCount: item['vote_count'],
          ));
        }
        movies.assignAll(movieList);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
