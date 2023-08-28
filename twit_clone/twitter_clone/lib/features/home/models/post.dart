class User {
  String name;
  String profileUrl;
  String userId;
  User({required this.name, required this.profileUrl, required this.userId});
}

class Post {
  String owner;
  String profileUrl;
  bool liked;
  bool blueMarked; // 먼지 모르겠지만 있음
  int likeCount;
  //int createdAt;
  String hours;
  List<User>? replyUser;
  String? content;
  List<String>? images;

  Post(
      {required this.owner,
      required this.profileUrl,
      required this.liked,
      required this.blueMarked,
      required this.likeCount,
      required this.hours,
      this.replyUser,
      this.content,
      this.images});
}
