import 'package:anim_final/common/app.dart';
import 'package:anim_final/gametitle_detail_screen.dart';
import 'package:flutter/material.dart';

import 'common/durations.dart';
import 'gametitles_slider_screen.dart';
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
      home: const MyHomePage(title: 'Animation Final Challenge'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Size _size;
  late bool _scrolledDown = true;
  late GameTitle gameTitle = gameTitles[1];
  late String? prevImageUrl = gameTitle.imageUrl;
  int cartCount = 0;

  /// BGImage fade/position
  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: Durations.ms(500)); //const Duration(milliseconds: 500));
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  /// CART animations
  late final AnimationController _cartController = AnimationController(
      vsync: this,
      duration: Durations.sec(1)); //const Duration(milliseconds: 1000));
  late final Animation cartAnimX = Tween<double>(
          begin: MediaQuery.of(context).size.width / 2,
          end: MediaQuery.of(context).size.width - 36)
      .animate(_cartController);
  late final Animation cartAnimY =
      Tween<double>(begin: 40, end: MediaQuery.of(context).size.height - 80)
          .animate(_cartController);
  late final Animation cartOpacity =
      Tween<double>(begin: 1.0, end: 0).animate(_cartController);

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _cartController.forward(from: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _cartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 : 페이지 이동 시 상하 이동 애니매이션
          buildScrollBackgroundImages(context, _size),
          Container(
            /// filter
            width: _size.width,
            height: _size.height,
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
                _scrolledDown = index == 0;
                print("_scrolledToDown is $_scrolledDown");
              });
            },
            children: [
              GameTitleDetailScreen(
                  width: _size.width,
                  height: _size.height,
                  gameTitle: gameTitle,
                  scrolledDown: _scrolledDown),
              GameTitlesSliderScreen(
                width: _size.width,
                height: _size.height,
                gameTitles: gameTitles,
                scrolledDown: _scrolledDown,
                onTitleSelected: (index) {
                  setState(() {
                    prevImageUrl = gameTitle.imageUrl;
                    gameTitle = gameTitles[index];
                    // _controller.forward(from: 0);
                  });
                },
                onAddCart: (index) {
                  _cartController.forward(from: 0).whenComplete(
                      () => setState(() => cartCount = cartCount + 1));
                },
              ),
            ],
          ),
          buildCartIcon(context),
          buildCartAnimIcon(context),
        ],
      ),
    );
  }

  Widget buildScrollBackgroundImages(BuildContext context, Size size) {
    return AnimatedPositioned(
      duration: Durations.ms(2000),
      top: _scrolledDown ? -20 : 0,
      width: _size.width,
      height: _size.height + 40,
      child: Stack(children: [
        SizedBox(
          width: _size.width,
          height: _size.height + 40,
          child: Image.network(
            prevImageUrl!,
            fit: BoxFit.cover,
          ),
        ),
        FadeTransition(
          opacity: _animation,
          child: SizedBox(
            width: _size.width,
            height: _size.height + 40,
            child: Image.network(
              gameTitle.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildCartIcon(BuildContext context) {
    return Positioned(
      right: 10,
      top: 60,
      child: Container(
        width: 50,
        height: 50,
        child: Stack(
          children: [
            const Center(
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white70,
                size: 40,
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    "$cartCount",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCartAnimIcon(BuildContext context) {
    return AnimatedBuilder(
        animation: _cartController,
        builder: (context, child) {
          return Positioned(
            left: cartAnimX.value,
            bottom: cartAnimY.value,
            child: AnimatedOpacity(
              opacity: cartOpacity.value,
              duration: Durations.ms(800), //const Duration(milliseconds: 800),
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: const Center(
                  child: Text(
                    "1",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          );
        });
  }

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
          "Tomb Raider: Anniversary retraces Lara Croft's original genre-defining adventure  globe-trotting 3rd person action-adventure in pursuit of the legendary Scion artifact.",
      // videoUrl:
      //     "https://cdn.cloudflare.steamstatic.com/steam/apps/256663321/movie480.webm?t=1461660154",
      steamUrl: "https://store.steampowered.com/app/203160/Tomb_Raider/",
    ),
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
          "Make Painfully Great Memories with Your Friends in Party Animals. Mess With Your Friend in 100 Different Ways Or Together You Could Eliminate Others, Teamwork Is Also Highly Appreciated Here, Especially When Fighting For Gummy Bear",
      videoUrl:
          "https://cdn.cloudflare.steamstatic.com/steam/apps/256970611/movie480_vp9.webm?t=1695209077",
      steamUrl: "https://store.steampowered.com/app/1260320/Party_Animals/",
    ),
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
          "Baldur’s Gate 3 is a story-rich, party-based RPG set in the universe of Dungeons & Dragons, where your choices shape a tale of fellowship and betrayal, survival and sacrifice, and the lure of absolute power.",
      // videoUrl:
      //     "https://cdn.cloudflare.steamstatic.com/steam/apps/256961600/movie480_vp9.webm?t=1695393579",
      steamUrl: "https://store.steampowered.com/app/1086940/Baldurs_Gate_3/",
    ),
  ];
}
