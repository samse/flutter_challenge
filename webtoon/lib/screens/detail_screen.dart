import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflix2/models/movie_detail.dart';
import 'package:toonflix2/models/webtoon_detail.dart';
import 'package:toonflix2/models/webtoon_episode.dart';
import 'package:toonflix2/models/webtoon_model.dart';
import 'package:toonflix2/services/api_services.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants.dart';

class DetailMovieScreen extends StatefulWidget {
  final String movieId;
  const DetailMovieScreen({super.key, required this.movieId});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  @override
  Widget build(BuildContext context) {
    Future<MovieDetailModel> model =
        ApiServices.fetchMovieDetail(widget.movieId);
    return Scaffold(
      body: FutureBuilder(
        future: model,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500/${snapshot.data!.poster_path}",
                    fit: BoxFit.fitHeight,
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black12,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 100,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Back to list",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 300,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            snapshot.data!.original_title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        /// 5 star
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: (snapshot.data!.vote_average > 2.0)
                                    ? Colors.yellow
                                    : Colors.white30,
                              ),
                              Icon(
                                Icons.star,
                                color: (snapshot.data!.vote_average > 4.0)
                                    ? Colors.yellow
                                    : Colors.white30,
                              ),
                              Icon(
                                Icons.star,
                                color: (snapshot.data!.vote_average > 6.0)
                                    ? Colors.yellow
                                    : Colors.white30,
                              ),
                              Icon(
                                Icons.star,
                                color: (snapshot.data!.vote_average > 7.0)
                                    ? Colors.yellow
                                    : Colors.white30,
                              ),
                              Icon(
                                Icons.star,
                                color: (snapshot.data!.vote_average > 9.0)
                                    ? Colors.yellow
                                    : Colors.white30,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            "StoryLine",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0, // shadow blur
                                  color: Colors.white, // shadow color
                                  offset: Offset(2.0,
                                      2.0), // how much shadow will be shown
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 30.0),
                        //   child: Text(
                        //     "${getGenreStr(snapshot.data!.genres)}",
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Text(
                            snapshot.data!.overview,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              shadows: [
                                Shadow(
                                  blurRadius: 10.0, // shadow blur
                                  color: Colors.white, // shadow color
                                  offset: Offset(2.0,
                                      2.0), // how much shadow will be shown
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Buy ticket",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  String getGenreStr(List<Map<String, dynamic>> genres) {
    String result = "";
    for (var genre in genres) {
      result = "${result} ${genre["name"]}";
    }
    return result;
  }
}

class DetailScreen extends StatefulWidget {
  final WebtoonModel webtoon;

  const DetailScreen({super.key, required this.webtoon});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetail> detail;
  late Future<List<WebtoonEpisode>> episodes;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    detail = ApiServices.getDetails(widget.webtoon.id);
    episodes = ApiServices.getEpisode(widget.webtoon.id);

    loadFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heroWidget(),
              webtoonListWidget(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBarWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Res.keyColor,
      title: Text(
        widget.webtoon.title,
        style: const TextStyle(
          color: Res.keyColor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isFavorite = !isFavorite;
            });
            saveFavorite();
          },
          icon: Icon(
            isFavorite
                ? Icons.favorite_outlined
                : Icons.favorite_outline_outlined,
            color: Res.keyColor,
          ),
        ),
      ],
    );
  }

  FutureBuilder<WebtoonDetail> webtoonListWidget() {
    return FutureBuilder(
        future: detail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data!.about,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('${snapshot.data!.genre}/${snapshot.data!.age}'),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                    future: episodes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var episodes = snapshot.data!;
                        return Column(
                          children: [
                            for (var episode in episodes)
                              makeEpisodeBar(episode, widget.webtoon.id)
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Hero heroWidget() {
    return Hero(
      tag: widget.webtoon.id,
      child: Container(
        width: 250,
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
          widget.webtoon.thumb,
          headers: const {
            "User-Agent":
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
          },
        ),
      ),
    );
  }

  Hero makeDetailView() {
    return Hero(
      tag: widget.webtoon.id,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Column(
              children: [
                Container(
                  width: 250,
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
                  child: Image.network(widget.webtoon.thumb),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void buttonTap(String webtoonId, String episodeId) async {
    try {
      await launchUrlString(
          'https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=$episodeId');
    } on Exception catch (_, e) {
      print(e);
    }
  }

  Widget makeEpisodeBar(WebtoonEpisode episode, String webtoonId) {
    return GestureDetector(
      onTap: () => buttonTap(webtoonId, episode.id),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(1, 1),
              )
            ],
            color: Res.keyColor,
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AutoSizeText(
                    episode.title,
                    style: Res.detailStyleEpisode,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                ),
              ],
            ),
          )),
    );
  }

  ///
  ///
  void loadFavorite() async {
    final SharedPreferences prefs = await _prefs;
    final bool? ret = prefs.getBool(PrefKeys.favoriteKey(widget.webtoon.id));
    print('load favorite : $ret');
    if (ret != null) {
      setState(() {
        isFavorite = ret;
      });
    }
  }

  void saveFavorite() async {
    final SharedPreferences prefs = await _prefs;
    print('save favorite : $isFavorite');
    prefs.setBool(PrefKeys.favoriteKey(widget.webtoon.id), isFavorite);
  }
}
