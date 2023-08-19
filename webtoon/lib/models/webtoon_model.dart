class WebtoonModel {
  final String title, thumb, id;

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];

  @override
  String toString() {
    return 'id=$id, title=$title, thumb=$thumb';
  }
}
