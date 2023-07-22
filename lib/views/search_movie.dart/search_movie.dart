import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/movie_controller.dart';
import '../../models/movie_model.dart';
import '../../utils/color_utils.dart';

class SearchMovieResult extends StatefulWidget {
  const SearchMovieResult({super.key, required this.query});

  final String query;

  @override
  State<SearchMovieResult> createState() => _SearchMovieResultState();
}

class _SearchMovieResultState extends State<SearchMovieResult> {
  final SearchMovie movieController = Get.put(SearchMovie());
  @override
  void initState() {
    movieController.fetchMovies(widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.backgroundColor,
        iconTheme: const IconThemeData(
          color: ColorUtils.textColor,
        ),
        title: Text('Search ${widget.query}'),
      ),
      body: Obx(
        () => movieController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: movieController.movies.length,
                itemBuilder: (context, index) {
                  SearchMovieModel movie = movieController.movies[index];
                  return ListTile(
                    title: Text(
                      movie.title,
                      style: const TextStyle(
                          color: ColorUtils.textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      movie.overview,
                      style: TextStyle(
                          color: ColorUtils.textColor.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),
                    leading: Image.network(movie.posterPath),
                  );
                },
              ),
      ),
    );
  }
}
