import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'gametitle_screen.dart';
import 'model/gametitle.dart';

class GameTitleSliderScreen extends StatefulWidget {
  final double width;
  final double height;
  final List<GameTitle> gameTitles;
  final int selectedIndex = 0;
  final Function? onTitleSelected;
  final bool dropDowned; // 하단으로 스크롤되어 안보이는 상태, 흰색 배경박스의 머리 부분이 보여야 함.
  const GameTitleSliderScreen(
      {Key? key,
      required this.width,
      required this.height,
      required this.gameTitles,
      required this.dropDowned,
      this.onTitleSelected})
      : super(key: key);

  @override
  State<GameTitleSliderScreen> createState() => _GameTitleSliderScreenState();
}

class _GameTitleSliderScreenState extends State<GameTitleSliderScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // print("${_scrollController.position.pixels}");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: PageView(
        controller: PageController(
          initialPage: _currPage,
          viewportFraction: 0.8,
        ),
        onPageChanged: (index) {
          print("pageChanged: $index");
          if (widget.onTitleSelected != null) {
            widget.onTitleSelected!(index);
          }
          setState(() {
            _currPage = index;
          });
        },
        children: [
          for (final item in widget.gameTitles.asMap().entries)
            buildTitleScreen(
                gameTitle: item.value, selected: (item.key == _currPage))
          // for (final gameTitle in widget.gameTitles)
          //   buildTitleScreen(gameTitle, selected: index)
        ],
      ),
    );
  }

  Widget buildTitleScreen(
      {required GameTitle gameTitle, required bool selected}) {
    return GameTitleScreen(
      width: widget.width * 0.8,
      height: widget.height,
      gameTitle: gameTitle,
      selected: selected,
      dropDowned: widget.dropDowned,
    );
  }
}
