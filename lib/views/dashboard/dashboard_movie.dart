import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/utils/color_utils.dart';
import 'package:movie_app/views/dashboard/component/app_bar_movie.dart';
import 'package:movie_app/views/dashboard/detail_movie.dart';
import 'package:movie_app/views/now_playing/now_playing_all.dart';
import 'package:movie_app/views/recommended/recommended_all.dart';
import 'package:movie_app/views/search_movie.dart/search_movie.dart';

import '../../controllers/movie_controller.dart';
import '../../models/movie_model.dart';

class DashboardMovie extends StatefulWidget {
  const DashboardMovie({super.key});

  @override
  State<DashboardMovie> createState() => _DashboardMovieState();
}

class _DashboardMovieState extends State<DashboardMovie> {
  ScrollController _scrollController = ScrollController();
  bool _isVisible = false;
  final MovieController movieController = Get.put(MovieController());
  final NowPlayingMovieController nowPlayingController =
      Get.put(NowPlayingMovieController());
  final RecomendationMovieController recomenMovieController =
      Get.put(RecomendationMovieController());
  final CarouselController carouselController = CarouselController();
  int _currentCarouselIndex = 0;
  TextEditingController searchMovie = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 100 && _isVisible) {
        setState(() {
          _isVisible = false;
        });
      } else if (_scrollController.position.pixels >= 100 && !_isVisible) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose the ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.backgroundColor,
      body: Obx(
        () => movieController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : buildCarouselWithBlurBackground(context),
      ),
    );
  }

  Widget buildCarouselWithBlurBackground(BuildContext context) {
    return Stack(
      children: [
        buildBlurBackground(movieController
            .movies[movieController.currentMovieIndex.value].posterPath),
        SafeArea(
          child: ListView(
            controller: _scrollController,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: AppBarMovie(
                  ontap: () {
                    showCustomTextFieldDialog(context);
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              buildCarousel(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  movieController.movies.length,
                  (index) => buildIndicator(index),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recommendations Movie',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorUtils.textColor,
                          letterSpacing: 0.5),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RecommendenAll()));
                      },
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorUtils.buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: Obx(
                  () => recomenMovieController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: recomenMovieController.movies.length,
                          itemBuilder: (context, index) {
                            Movie movie = recomenMovieController.movies[index];
                            return Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailMoview(
                                                      movie: movie,
                                                    )));
                                      },
                                      child: Container(
                                        height: 150,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    movie.posterPath),
                                                fit: BoxFit.cover)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines:
                                            2, // this will show dots(...) after 2 lines
                                        strutStyle:
                                            const StrutStyle(fontSize: 12.0),
                                        text: TextSpan(
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: ColorUtils.textColor),
                                            text: movie.title),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            );
                          },
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Now Playing',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorUtils.textColor,
                          letterSpacing: 0.5),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NowPlayingAll()));
                      },
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorUtils.buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: Obx(
                  () => nowPlayingController.isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: nowPlayingController.movies.length,
                          itemBuilder: (context, index) {
                            Movie movie = nowPlayingController.movies[index];
                            return Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailMoview(
                                                      movie: movie,
                                                    )));
                                      },
                                      child: SizedBox(
                                        height: 150,
                                        width: 250,
                                        child: Stack(children: [
                                          Opacity(
                                            opacity:
                                                0.7, // Adjust the opacity value as needed (0.0 to 1.0)
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      movie.posterPath),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 2,
                                            left: 5,
                                            child: SizedBox(
                                              child: RichText(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines:
                                                    2, // this will show dots(...) after 2 lines
                                                strutStyle: const StrutStyle(
                                                    fontSize: 16.0),
                                                text: TextSpan(
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        color: ColorUtils
                                                            .textColor),
                                                    text: movie.title),
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            );
                          },
                        ),
                ),
              ),
              Container(
                height: 20,
                color: ColorUtils.backgroundColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showCustomTextFieldDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Search Movie'),
        content: TextField(
          controller: searchMovie,
          decoration: const InputDecoration(
            hintText: 'Type here...',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text("Continue"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchMovieResult(
                            query: searchMovie.text,
                          )));
            },
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentCarouselIndex == index
            ? ColorUtils.buttonColor
            : Colors.grey,
      ),
    );
  }

  Widget buildBlurBackground(String imageUrl) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: _isVisible ? 0.0 : 1.0, // Adjust the opacity condition here
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
      ),
    );
  }

  Widget buildCarousel(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: carouselController,
      itemCount: movieController.movies.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        Movie movie = movieController.movies[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailMoview(
                          movie: movie,
                        )));
          },
          child: SizedBox(
            height: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(() {
            _currentCarouselIndex = index;
          });
          movieController.currentMovieIndex.value = index;
        },
      ),
    );
  }
}
