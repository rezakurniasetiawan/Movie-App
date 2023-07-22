import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/utils/color_utils.dart';

class DetailMoview extends StatefulWidget {
  const DetailMoview({super.key, required this.movie});

  final Movie movie;

  @override
  State<DetailMoview> createState() => _DetailMoviewState();
}

class _DetailMoviewState extends State<DetailMoview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.backgroundColor,
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(widget.movie.posterPath),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Positioned(
                        left: 10,
                        top: 10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.movie.title,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.textColor,
                    letterSpacing: 0.5),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Release ${widget.movie.releaseDate} ',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: ColorUtils.textColor,
                    letterSpacing: 0.5),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorUtils.buttonColor),
                      child: const Center(
                        child: Text(
                          'Play Now',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorUtils.textColor,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                widget.movie.overview,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: ColorUtils.textColor,
                    letterSpacing: 0.5),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
