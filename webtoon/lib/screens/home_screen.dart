import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:toonflix2/models/webtoon_model.dart';
import 'package:toonflix2/screens/detail_screen.dart';
import 'package:toonflix2/services/api_services.dart';

import '../constants.dart';
import '../models/movie_model.dart';
import '../widgets/webtoon_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<List<WebtoonModel>> webtoons = ApiServices.getTodaysToons();
    Future<Map<String, List<MovieModel>>> allMovies =
        ApiServices.fetchAllMovies();
    return Scaffold(
      body: FutureBuilder(
        future: allMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    "Popular Movies",
                    style: TextStyle(
                      fontSize: MovieTitleTextSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(child: makePopularList(snapshot)),
                  const SizedBox(height: 20),
                  const Text(
                    "Now in Cinemas",
                    style: TextStyle(
                      fontSize: MovieTitleTextSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(child: makeNowPlayingList(snapshot)),
                  const SizedBox(height: 20),
                  const Text(
                    "Coming soon",
                    style: TextStyle(
                      fontSize: MovieTitleTextSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(child: makeComingSoonList(snapshot)),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  ListView makePopularList(
      AsyncSnapshot<Map<String, List<MovieModel>>> snapshot) {
    print("makePopularList");
    List<MovieModel> movies = snapshot.data!["popular"]!;
    print("  movies : $movies");

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        var movie = movies[index];
        return MovieCard(
          type: MovieCardType.big,
          movie: movie,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }

  ListView makeNowPlayingList(
      AsyncSnapshot<Map<String, List<MovieModel>>> snapshot) {
    List<MovieModel> movies = snapshot.data!["nowPlaying"]!;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        var movie = movies[index];
        return MovieCard(
          type: MovieCardType.small,
          movie: movie,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }

  ListView makeComingSoonList(
      AsyncSnapshot<Map<String, List<MovieModel>>> snapshot) {
    List<MovieModel> movies = snapshot.data!["comingSoon"]!;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        var movie = movies[index];
        return MovieCard(
          type: MovieCardType.small,
          movie: movie,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return WebtoonCard(webtoon: webtoon);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 40),
    );
  }
}

enum MovieCardType { big, small }

const MovieTitleTextSize = 28.0;
const MovieDescTextSize = 16.0;

class MovieCard extends StatefulWidget {
  final MovieModel movie;
  final MovieCardType type;
  const MovieCard({
    super.key,
    required this.movie,
    required this.type,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  void _onTapMovie(int movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailMovieScreen(movieId: "${movieId}"),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.type == MovieCardType.big)
          GestureDetector(
            onTap: () => _onTapMovie(widget.movie.id),
            child: Container(
              width: 290,
              height: 200,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                      color: Colors.black.withOpacity(0.5)),
                ],
              ),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500/${widget.movie.poster_path}",
                fit: BoxFit.fitWidth,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
          )
        else
          Column(
            children: [
              GestureDetector(
                onTap: () => _onTapMovie(widget.movie.id),
                child: Container(
                  width: 160,
                  height: 160,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          offset: const Offset(1, 1),
                          color: Colors.black.withOpacity(0.5)),
                    ],
                  ),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500/${widget.movie.poster_path}",
                    fit: BoxFit.fitWidth,
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 160,
                child: Text(
                  widget.movie.title,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: MovieDescTextSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ), // Container(
      ],
    );
  }
}

class MiniMovieCard extends StatefulWidget {
  final MovieModel movie;
  const MiniMovieCard({super.key, required this.movie});

  @override
  State<MiniMovieCard> createState() => _MiniMovieCardState();
}

class _MiniMovieCardState extends State<MiniMovieCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 160,
          height: 160,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  offset: const Offset(1, 1),
                  color: Colors.black.withOpacity(0.5)),
            ],
          ),
          child: Image.network(
            "https://image.tmdb.org/t/p/w500/${widget.movie.poster_path}",
            fit: BoxFit.fitWidth,
            headers: const {
              "User-Agent":
                  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
            },
          ),
        ), // Container(
        SizedBox(
          height: 10,
        ),
        Container(
          width: 160,
          child: Text(
            widget.movie.title,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MovieDescTextSize,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
