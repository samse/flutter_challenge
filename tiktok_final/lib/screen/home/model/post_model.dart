enum MoodType {
  smile_1,
  smile_2,
  smile_3,
  shy,
  eyedrop,
  angry,
  freakedout,
  obite
}

class PostModel {
  final MoodType moodType;
  final String comment;
  int? createdAt;
  PostModel({required this.moodType, required this.comment, this.createdAt});
}
