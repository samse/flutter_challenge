import 'package:anim_final/common/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'common/gaps.dart';
import 'model/gametitle.dart';

class GameTitleScreen extends StatelessWidget {
  final double width;
  final double height;
  final GameTitle gameTitle;
  final bool selected;
  final bool dropDowned; // true이면 희색박스가 보여야 함.
  const GameTitleScreen({
    Key? key,
    required this.width,
    required this.height,
    required this.gameTitle,
    required this.selected,
    required this.dropDowned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build TitleScreen");
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          if (!dropDowned)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                width: width,
                height: 40,
                child: Center(
                  child: Transform.rotate(
                    angle: -1.55,
                    child: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          // 배경 박스
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: dropDowned ? 10 : height * 0.2,
            left: 0,
            right: 0,
            bottom: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: width,
                height: height * 0.7,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Stack(children: [
                  Column(
                    children: [
                      SizedBox(height: 200),
                      Center(
                        child: Text(
                          "\"${gameTitle.title}\"",
                          textAlign: TextAlign.center,
                          style: context.textTheme.headlineLarge!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Gaps.v16,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          gameTitle.shortDescription,
                          style: context.headlineMin
                              .copyWith(fontSize: 16, color: Colors.black38),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        Text(
                          "Official Rating",
                          style:
                              context.headlineMin.copyWith(color: Colors.black),
                        ),
                        Gaps.v8,
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: gameTitle.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Gaps.v16,
                        Container(
                          width: width,
                          height: 60,
                          color: Colors.blue,
                          child: Center(
                            child: Text(
                              "Add to cart +",
                              style: context.headlineMin
                                  .copyWith(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            top: height * 0.1,
            left: width * 0.6 / 3 + (selected ? 0 : 40),
            child: Container(
              width: width * 0.6,
              height: height * 0.3,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38, // 그림자 색상
                      offset: Offset(0, 1), // 그림자 위치 (x, y)
                      blurRadius: 15, // 그림자의 흐림 정도
                      spreadRadius: 20, // 그림자 확산 정도
                    ),
                  ]),
              child: Image.network(
                gameTitle.thumbnailUrl,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
