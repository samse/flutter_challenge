import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const MovieTitleTextSize = 28.0;
const MovieDescTextSize = 16.0;

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 180),
                const Text(
                  "Popular Movies",
                  style: TextStyle(
                    fontSize: MovieTitleTextSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 280,
                  height: 200,
                  clipBehavior: Clip.hardEdge,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500/it7yPSgca2VEJyXAqgjfaccgvJm.jpg",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Now Playing Movies",
                  style: TextStyle(
                    fontSize: MovieTitleTextSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 180,
                  child: Column(
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      const Text(
                        "JohnWick Chapter 4, JohnWick Chapter 4",
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: MovieDescTextSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Coming Soon Movies",
                  style: TextStyle(
                    fontSize: MovieTitleTextSize,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 180,
                  child: Column(
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      const Text(
                        "JohnWick Chapter 4, JohnWick Chapter 4",
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: MovieDescTextSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
