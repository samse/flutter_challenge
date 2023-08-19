class WebtoonEpisode {
  final String title, rating, date, id;

  WebtoonEpisode.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        rating = json['rating'],
        date = json['date'],
        id = json['id'];

  // @override
  // String toString() {
  //   return 'id=$id, title=$title, thumb=$thumb';
  // }
}
