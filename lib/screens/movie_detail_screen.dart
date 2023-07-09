import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toonflix/models/movie_detail_model.dart';
import 'package:toonflix/models/movie_model.dart';
import 'package:toonflix/services/movie_api_services.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.imgUrl,
    required this.movie,
  });

  final String imgUrl;
  final MovieModel movie;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<MovieDetailModel> futureMovie;

  @override
  void initState() {
    super.initState();
    futureMovie = MovieApiService.getDetailMovie(widget.movie.id);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              '${widget.imgUrl}${widget.movie.posterPath}',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      left: 4,
                    ),
                    child: Text(
                      'Back to list',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 230,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: FutureBuilder(
                  future: futureMovie,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final movie = snapshot.data!;
                      List<Icon> stars = [];
                      returnStars(movie, stars);
                      var genres = [
                        for (var genre in movie.genres) genre['name']
                      ].join(', ');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Row(
                            children: [
                              for (var star in stars)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 6,
                                    right: 4,
                                  ),
                                  child: star,
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text(
                                '${movie.runtime ~/ 60}h ${movie.runtime % 60}min',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                color: Colors.white.withOpacity(0.6),
                                width: 1,
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  genres,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Stroyline',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 50,
                            ),
                            child: Text(
                              movie.overview,
                              style: const TextStyle(
                                color: Colors.white,
                                height: 1.5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 8,
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
          Positioned(
            bottom: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 240,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'Buy ticket',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void returnStars(MovieDetailModel movie, List<Icon> stars) {
    int average = movie.vote_average.round();
    int starCount = average ~/ 2;
    int starHalf = average % 2;
    List.generate(
      starCount,
      (index) => stars.add(
        const Icon(
          Icons.star,
          color: Colors.yellow,
          size: 22,
        ),
      ),
    );
    List.generate(
      starHalf,
      (index) => stars.add(
        const Icon(
          Icons.star_half,
          color: Colors.yellow,
          size: 22,
        ),
      ),
    );
    List.generate(
      5 - starCount - starHalf,
      (index) => stars.add(
        Icon(
          Icons.star,
          color: Colors.white.withOpacity(0.4),
          size: 22,
        ),
      ),
    );
  }
}
