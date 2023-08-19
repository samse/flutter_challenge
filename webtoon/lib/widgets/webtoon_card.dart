import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/webtoon_model.dart';
import '../screens/detail_screen.dart';

class WebtoonCard extends StatefulWidget {
  const WebtoonCard({
    super.key,
    required this.webtoon,
  });

  final WebtoonModel webtoon;

  @override
  State<WebtoonCard> createState() => _WebtoonCardState();
}

class _WebtoonCardState extends State<WebtoonCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  void loadFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? ret = prefs.getBool(PrefKeys.favoriteKey(widget.webtoon.id));
    print('card load favorite : $ret');
    if (ret != null) {
      setState(() {
        isFavorite = ret;
      });
    }
  }

  void _navigateAndRefresh() async {
    print('show DetailScreen');
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(webtoon: widget.webtoon),
        fullscreenDialog: true,
      ),
    );
    print('refresh Card');
    loadFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateAndRefresh();
      },
      child: Column(
        children: [
          Hero(
            tag: widget.webtoon.id,
            child: Stack(
              alignment: const Alignment(0.9, -0.9),
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
                  child: Image.network(
                    widget.webtoon.thumb,
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                    scale: 0.5,
                  ),
                ),
                Icon(
                    isFavorite
                        ? Icons.favorite_outlined
                        : Icons.favorite_outline_outlined,
                    size: 40,
                    color: Res.keyColor),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.webtoon.title,
            style: Res.homeStyleTitle,
          ),
        ],
      ),
    );
  }
}
