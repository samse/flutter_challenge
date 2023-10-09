import 'package:flutter/material.dart';
import 'package:swipe_card/model/girl_group.dart';

class CoverCard extends StatelessWidget {
  final GirlGroup girlGroup;
  const CoverCard({super.key, required this.girlGroup});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Image.asset(
          "assets/covers/${girlGroup.imagePath}",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
