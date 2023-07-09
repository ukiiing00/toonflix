import 'package:flutter/material.dart';
import 'package:toonflix/models/movie_model.dart';
import 'package:toonflix/screens/movie_detail_screen.dart';

class MakeMovieList extends StatelessWidget {
  const MakeMovieList({
    super.key,
    required this.futureMovie,
    required this.imgUrl,
    required this.title,
    required this.onlyThumb,
  });

  final Future<List<MovieModel>> futureMovie;
  final String imgUrl, title;
  final bool onlyThumb;

  void _goDetailScreen(BuildContext context, MovieModel movie) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MovieDetailScreen(
        imgUrl: imgUrl,
        movie: movie,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureMovie,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 230,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return onlyThumb
                          ? GestureDetector(
                              onTap: () => _goDetailScreen(
                                context,
                                movies[index],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                clipBehavior: Clip.hardEdge,
                                width: 310,
                                child: Image.network(
                                  '$imgUrl${movies[index].posterPath}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : SizedBox(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () => _goDetailScreen(
                                      context,
                                      movies[index],
                                    ),
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.network(
                                        '$imgUrl${movies[index].posterPath}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () => _goDetailScreen(
                                      context,
                                      movies[index],
                                    ),
                                    child: Text(
                                      movies[index].title,
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 19,
                        ),
                    itemCount: movies.length),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
