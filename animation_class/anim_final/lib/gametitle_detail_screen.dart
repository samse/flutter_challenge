import 'package:anim_final/common/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:video_player/video_player.dart';

import 'common/durations.dart';
import 'common/gaps.dart';
import 'model/gametitle.dart';

class GameTitleDetailScreen extends StatefulWidget {
  final double width;
  final double height;
  final GameTitle gameTitle;
  final bool scrolledDown;

  const GameTitleDetailScreen(
      {Key? key,
      required this.width,
      required this.height,
      required this.gameTitle,
      required this.scrolledDown})
      : super(key: key);

  @override
  State<GameTitleDetailScreen> createState() => _GameTitleDetailScreenState();
}

class _GameTitleDetailScreenState extends State<GameTitleDetailScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController =
        VideoPlayerController.networkUrl(Uri.parse(widget.gameTitle.videoUrl!))
          ..initialize().then((value) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _toggleVideo() {
    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
      } else {
        _videoController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.width,
          height: widget.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gaps.v80,
                Center(
                  child: AnimatedRotation(
                    turns: widget.scrolledDown ? 1.0 : 0.5,
                    duration:
                        Durations.ms(300), //const Duration(milliseconds: 300),
                    child: AnimatedScale(
                      scale: widget.scrolledDown ? 1.0 : 0.2,
                      duration:
                          Durations.ms(800), // const Duration(seconds: 800),
                      child: Text(
                        widget.gameTitle.title,
                        textAlign: TextAlign.center,
                        style: context.ultraTitle.copyWith(
                            fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
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
                  initialRating: widget.gameTitle.rating,
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
                  child: Text(
                    widget.gameTitle.description,
                    style: context.textTheme.headlineSmall!
                        .copyWith(color: Colors.white60, fontSize: 20),
                  ),
                ),
                Gaps.v32,
                if (widget.gameTitle.videoUrl != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "WATCH TRAILER",
                      textAlign: TextAlign.center,
                      style: context.pageTitle.copyWith(
                          color: Colors.white70, fontWeight: FontWeight.w600),
                    ),
                  ),
                if (widget.gameTitle.videoUrl != null) Gaps.v16,
                if (widget.gameTitle.videoUrl != null)
                  buildVideoWidget(context),
                Gaps.v64,
              ],
            ),
          ),
        ),

        /// 하단 화살표
        if (widget.scrolledDown)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AnimatedContainer(
              duration: Durations.sec(2), // const Duration(milliseconds: 2000),
              width: widget.width,
              height: 40,
              child: Center(
                child: Transform.rotate(
                  angle: widget.scrolledDown ? 1.55 : -1.55,
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

  Widget buildVideoWidget(BuildContext context) {
    print("buildVideoWidget : ${widget.gameTitle.videoUrl}");
    return Center(
      child: _videoController.value.isInitialized
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_videoController),
                    GestureDetector(
                      onTap: _toggleVideo,
                      child: Center(
                        child: Icon(
                          _videoController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow_sharp,
                          color: Colors.white60,
                          size: 80,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const CircularProgressIndicator.adaptive(),
    );
  }
}
