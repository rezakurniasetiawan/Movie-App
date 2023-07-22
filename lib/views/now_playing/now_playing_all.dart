import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:movie_app/controllers/movie_controller.dart';

import '../../models/movie_model.dart';
import '../../utils/color_utils.dart';

class NowPlayingAll extends StatefulWidget {
  const NowPlayingAll({super.key});

  @override
  State<NowPlayingAll> createState() => _NowPlayingAllState();
}

class _NowPlayingAllState extends State<NowPlayingAll> {
  final NowPlayingMovieController movieController =
      Get.put(NowPlayingMovieController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorUtils.backgroundColor,
        iconTheme: const IconThemeData(
          color: ColorUtils.textColor,
        ),
        title: Text('Movie App'),
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
