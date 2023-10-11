import 'package:anim_final/common/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'common/gaps.dart';
import 'model/gametitle.dart';

class GameTitleDetailScreen extends StatelessWidget {
  final double width;
  final double height;
  final GameTitle gameTitle;
  final bool arrowToDown;
  const GameTitleDetailScreen(
      {Key? key,
      required this.width,
      required this.height,
      required this.gameTitle,
      required this.arrowToDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gaps.v80,
                Center(
                  child: Text(
                    gameTitle.title,
                    textAlign: TextAlign.center,
                    style: context.ultraTitle.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
                Gaps.v12,
                Text(
                  "Official Rating",
                  style: context.headlineMin.copyWith(color: Colors.white),
                ),
                Gaps.v8,
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: gameTitle.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Gaps.v24,
                const Divider(
                  height: 1,
                  indent: 40,
                  endIndent: 40,
                  color: Colors.white38,
                ),
                Gaps.v24,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/ps4.png",
                      width: 120,
                      height: 80,
                    ),
                    Gaps.h24,
                    Image.asset(
                      "assets/images/xboxone.png",
                      width: 120,
                      height: 80,
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/steam-logo.png",
                      width: 120,
                      height: 80,
                    ),
                    Gaps.h24,
                    Image.asset(
                      "assets/images/geforce_now.png",
                      width: 120,
                      height: 80,
                    )
                  ],
                ),
                Gaps.v24,
                const Divider(
                  height: 1,
                  indent: 40,
                  endIndent: 40,
                  color: Colors.white38,
                ),
                Gaps.v24,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    height: height - (height / 2) - 170,
                    child: SingleChildScrollView(
                      child: Text(
                        gameTitle.description,
                        style: context.textTheme.headlineSmall!
                            .copyWith(color: Colors.white60, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (arrowToDown)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 2000),
              width: width,
              height: 40,
              child: Center(
                child: Transform.rotate(
                  angle: arrowToDown ? 1.55 : -1.55,
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
