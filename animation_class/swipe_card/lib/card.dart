import 'package:flutter/material.dart';
import 'package:swipe_card/data/girl_group.dart';

class CoverCard extends StatefulWidget {
  final GirlGroup girlGroup;
  const CoverCard({super.key, required this.girlGroup});

  @override
  State<CoverCard> createState() => _CoverCardState();
}

class _CoverCardState extends State<CoverCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  late final rotateAnim = Tween(begin: 0.0, end: 0.5).animate(_controller);
  late final fadeOut = Tween(begin: 1.0, end: 0.0).animate(_controller);
  late final fadeIn = Tween(begin: 0.0, end: 1.0).animate(_controller);

  bool _fliped = false;

  void _onTap() async {
    if (_fliped) {
      _controller.reverse();
    } else {
      await _controller.forward();
    }
    setState(() {
      _fliped = !_fliped;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(_controller.value * 3.14159265359),
                child: Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(10),
                  clipBehavior: Clip.hardEdge,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: size.width * 0.8,
                        height: size.width * 0.8 * 1.4,
                        child: Image.asset(
                          "assets/covers/${widget.girlGroup.imagePath}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _fliped
                  ? AnimatedOpacity(
                      opacity: fadeIn.value,
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        width: size.width * 0.8,
                        height: size.width * 0.8 * 1.4,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                        ),
                        child: Center(
                          child: Text(
                            widget.girlGroup.fandomName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 68,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  : AnimatedOpacity(
                      opacity: fadeOut.value,
                      duration: const Duration(milliseconds: 30),
                      child: SizedBox(
                          width: size.width * 0.8,
                          height: size.width * 0.8 * 1.4,
                          child: Center(
                              child: Text(
                            "What is \n${widget.girlGroup.name}'s fandom?",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                          ))),
                    ),
            ],
          );
        },
      ),
    );
  }
}
