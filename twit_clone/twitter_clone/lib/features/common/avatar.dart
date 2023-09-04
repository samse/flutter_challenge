import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String profileUrl;
  final Size size;
  final bool hasIcon;
  final bool blured;
  const Avatar(
      {super.key,
      required this.profileUrl,
      required this.size,
      this.hasIcon = false,
      this.blured = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.black38, width: 1.0)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(profileUrl,
                    fit: BoxFit.fitHeight,
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    }),
                if (blured)
                  BackdropFilter(
                      filter: ImageFilter.blur(
                          sigmaX: 0.8, sigmaY: 0.8), // 흐림 정도 조절
                      child: Container(
                        width: size.width,
                        height: size.height,
                        color: Colors.white38, // 배경색 투명으로 설정
                      )),
              ],
            ),
          ),
          if (hasIcon)
            Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                )),
          if (hasIcon)
            Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add_circle,
                    color: Colors.black,
                    size: 20,
                  ),
                )),
        ],
      ),
    );
  }
}
