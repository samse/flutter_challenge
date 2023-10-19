import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'gametitle_screen.dart';
import 'model/gametitle.dart';

class GameTitlesSliderScreen extends StatefulWidget {
  final double width;
  final double height;
  final List<GameTitle> gameTitles;
  final int selectedIndex = 0;
  final Function? onTitleSelected;
  final Function onAddKart;
  final bool scrolledDown;
  const GameTitlesSliderScreen({
    Key? key,
    required this.width,
    required this.height,
    required this.gameTitles,
    required this.scrolledDown,
    required this.onAddKart,
    this.onTitleSelected,
  }) : super(key: key);

  @override
  State<GameTitlesSliderScreen> createState() => _GameTitlesSliderScreenState();
}

class _GameTitlesSliderScreenState extends State<GameTitlesSliderScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currPage = 1;

  @override
  void initState() {
    super.initState();
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
        dropDowned: widget.scrolledDown,
        onAddCart: widget.onAddKart);
  }
}
