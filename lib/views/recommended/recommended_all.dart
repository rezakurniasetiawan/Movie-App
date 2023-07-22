import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/utils/color_utils.dart';

import '../../controllers/movie_controller.dart';
import '../../models/movie_model.dart';

class RecommendenAll extends StatefulWidget {
  const RecommendenAll({super.key});

  @override
  State<RecommendenAll> createState() => _RecommendenAllState();
}

class _RecommendenAllState extends State<RecommendenAll> {
  final RecomendationMovieController movieController =
      Get.put(RecomendationMovieController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.backgroundColor,
        iconTheme: const IconThemeData(
          color: ColorUtils.textColor,
        ),
        title: Text('Recommended Movie'),
      ),
      body: Obx(
        () => movieController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: movieController.movies.length,
                itemBuilder: (context, index) {
                  Movie movie = movieController.movies[index];
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
