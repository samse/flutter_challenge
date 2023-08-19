class WebtoonDetail {
  final String title, about, genre, age;

  WebtoonDetail.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];

  // @override
  // String toString() {
  //   return 'id=$id, title=$title, thumb=$thumb';
  // }
}
