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
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 120),
                      titleText("Popular Movies"),
                      makePopularList(context, snapshot),
                      const SizedBox(height: 20),
                      titleText("Now in Cinemas"),
                      makeNowPlayingList(context, snapshot),
                      const SizedBox(height: 20),
                      titleText("Coming soon"),
                      makeComingSoonList(context, snapshot),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget titleText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: MovieTitleTextSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  SizedBox makePopularList(BuildContext context,
      AsyncSnapshot<Map<String, List<MovieModel>>> snapshot) {
    print("makePopularList");
    List<MovieModel> movies = snapshot.data!["popular"]!;
    print("  movies : $movies");

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 230,
      child: ListView.separated(
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
      ),
    );
  }

  Widget makeNowPlayingList(BuildContext context,
      AsyncSnapshot<Map<String, List<MovieModel>>> snapshot) {
    List<MovieModel> movies = snapshot.data!["nowPlaying"]!;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230,
      child: ListView.separated(
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
      ),
    );
  }

  Widget makeComingSoonList(BuildContext context,
      AsyncSnapshot<Map<String, List<MovieModel>>> snapshot) {
    List<MovieModel> movies = snapshot.data!["comingSoon"]!;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: ListView.separated(
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
      ),
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
                  maxLines: 2,
                  overflow: TextOverflow.fade,
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
