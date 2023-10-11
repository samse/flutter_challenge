import 'package:anim_final/detail_screen.dart';
import 'package:flutter/material.dart';

import 'gametitle_screen.dart';
import 'gametitle_slider.dart';
import 'model/gametitle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late Size? _size;
  late double _startPos;
  late bool _arrowToDown = true;

  late List<GameTitle> gameTitles = [
    GameTitle(
        title: "Shadow of the Tomb Rider",
        rating: 4.5,
        description:
            "Tomb Raider: Anniversary retraces Lara Croft's original genre-defining adventure  globe-trotting 3rd person action-adventure in pursuit of the legendary Scion artifact. Using an enhanced 'Tomb Raider: Legend' game engine, the graphics, technology and physics bring Lara's adventure and pursuit of a mystical artifact known only as the Scion right up to today's technology standards and offers gamers a completely new gameplay experience. Re-imagined, Anniversary delivers a dynamic fluidly and fast Lara Croft, massive environments of stunning visuals, intense combat and game pacing, and an enhanced and clarified original story",
        publishers: ["PS2", "STEAM", "XBOX", "GEFORCE"],
        imageUrl:
            "https://cdn.cloudflare.steamstatic.com/steam/apps/8000/0000002093.600x338.jpg?t=1694707765",
        thumbnailUrl:
            "https://image.api.playstation.com/cdn/HP0700/CUSA06059_00/1pKIuEt3r7LNYoFmaMpFJWadafxq69LNNulfsCU5nzumaGPuRIF8eEV4XQoqlRxx.png",
        shortDescription:
            "Tomb Raider: Anniversary retraces Lara Croft's original genre-defining adventure  globe-trotting 3rd person action-adventure in pursuit of the legendary Scion artifact."),
    GameTitle(
        title: "Party Animals",
        rating: 3.5,
        description:
            "Fight your friends as puppies, kittens and other fuzzy creatures in PARTY ANIMALS! Paw it out with your friends remotely, or huddle together for chaotic fun on the same screen. Interact with the world under our realistic physics engine. Did I mention PUPPIES?",
        publishers: ["PS2", "STEAM", "XBOX", "GEFORCE"],
        imageUrl:
            "https://cdn.cloudflare.steamstatic.com/steam/apps/1260320/ss_18fa4ea184c84befeef65bc4518aa26f4084c6c0.600x338.jpg?t=1695243290",
        thumbnailUrl:
            "https://cdn.cloudflare.steamstatic.com/steam/apps/1260320/header.jpg?t=1695243290",
        shortDescription:
            "Make Painfully Great Memories with Your Friends in Party Animals. Mess With Your Friend in 100 Different Ways Or Together You Could Eliminate Others, Teamwork Is Also Highly Appreciated Here, Especially When Fighting For Gummy Bear"),
    GameTitle(
        title: "Baldur's Gate 3",
        rating: 3.5,
        description:
            "Baldur’s Gate 3 is a story-rich, party-based RPG set in the universe of Dungeons & Dragons, where your choices shape a tale of fellowship and betrayal, survival and sacrifice, and the lure of absolute power.",
        publishers: ["PS2", "STEAM", "XBOX", "GEFORCE"],
        imageUrl:
            "https://cdn.cloudflare.steamstatic.com/steam/apps/1086940/ss_73d93bea842b93914d966622104dcb8c0f42972b.600x338.jpg?t=1696948801",
        thumbnailUrl:
            "https://cdn.cloudflare.steamstatic.com/steam/apps/1086940/header.jpg?t=1696948801",
        shortDescription:
            "Baldur’s Gate 3 is a story-rich, party-based RPG set in the universe of Dungeons & Dragons, where your choices shape a tale of fellowship and betrayal, survival and sacrifice, and the lure of absolute power."),
  ];

  late GameTitle gameTitle = gameTitles[1];
  late String? prevImageUrl = gameTitle.imageUrl;

  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // print(_scrollController.position.pixels);
      if (_size != null) {
        _scrollController.position.pixels;
      }
    });
    _controller.forward();
  }

  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onEndScrolled() {
    _startPos = -1;
    setState(() {
      _arrowToDown = false;
    });
    Future.delayed(const Duration(milliseconds: 1), () {
      _startPos = -1;
      _scrollController.animateTo(_size!.height - 60.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  void _onStartScrolled() {
    print("scroll to 0");
    _startPos = -1;
    setState(() {
      _arrowToDown = true;
    });
    Future.delayed(const Duration(milliseconds: 1), () {
      _startPos = -1;
      _scrollController.animateTo(0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.decelerate);
    });
  }

  bool _onScrollNotification(Notification notification) {
    if (notification is ScrollStartNotification) {
      _startPos = _scrollController.position.pixels;
    } else if (notification is ScrollEndNotification) {
      // 스크롤 끝 이벤트 처리
      final endPos = _scrollController.position.pixels;
      if (_startPos != -1 && endPos > _startPos) {
        print('Scroll ended');
        _onEndScrolled();
        return true;
      } else if (_startPos != -1 && endPos < _startPos) {
        _onStartScrolled();

        return true;
      }
    }
    return false;
  }

  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000));
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            top: _arrowToDown ? -20 : 0,
            width: _size!.width,
            height: _size!.height + 40,
            child: Stack(children: [
              SizedBox(
                width: _size!.width,
                height: _size!.height + 40,
                child: Image.network(
                  prevImageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              FadeTransition(
                opacity: _animation,
                child: SizedBox(
                  width: _size!.width,
                  height: _size!.height + 40,
                  child: Image.network(
                    gameTitle.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ]),
          ),
          Container(
            width: _size!.width,
            height: _size!.height,
            color: Colors.black.withOpacity(0.2),
          ),
          PageView(
            controller: PageController(
              initialPage: 0,
              viewportFraction: 0.9,
            ),
            scrollDirection: Axis.vertical,
            onPageChanged: (index) {
              setState(() {
                _arrowToDown = index == 0;
                print("_arrowToDown is $_arrowToDown");
              });
            },
            children: [
              DetailScreen(
                  width: _size!.width,
                  height: _size!.height,
                  gameTitle: gameTitle,
                  arrowToDown: _arrowToDown),
              GameTitleSliderScreen(
                width: _size!.width,
                height: _size!.height,
                gameTitles: gameTitles,
                dropDowned: _arrowToDown,
                onTitleSelected: (index) {
                  setState(() {
                    prevImageUrl = gameTitle.imageUrl;
                    gameTitle = gameTitles[index];
                    _controller.forward(from: 0);
                  });
                },
              ),
            ],
          )
          // 콘텐츠 영역
          // NotificationListener(
          //   onNotification: _onScrollNotification,
          //   child: SingleChildScrollView(
          //     controller: _scrollController,
          //     child: Column(
          //       children: [
          //         DetailScreen(
          //             width: _size!.width,
          //             height: _size!.height,
          //             gameTitle: gameTitle,
          //             arrowToDown: _arrowToDown),
          //         GameTitleSliderScreen(
          //           width: _size!.width,
          //           height: _size!.height,
          //           gameTitles: gameTitles,
          //           dropDowned: _arrowToDown,
          //           onTitleSelected: (index) {
          //             setState(() {
          //               gameTitle = gameTitles[index];
          //             });
          //           },
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
