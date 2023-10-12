class GameTitle {
  final String title;
  final double rating;
  final String description;
  final List<String> publishers;
  final String? videoUrl;
  final String imageUrl;
  final String thumbnailUrl;
  final String shortDescription;
  final String steamUrl;
  GameTitle({
    required this.title,
    required this.rating,
    required this.description,
    required this.publishers,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.shortDescription,
    required this.steamUrl,
    this.videoUrl,
  });
}
