import '../../search/models/user.dart';

class Post {
  String? postId;
  String owner;
  String userName;
  String profileUrl;
  bool? liked;
  bool? blueMarked; // 먼지 모르겠지만 있음
  int? likeCount;
  //int createdAt;
  String hours;
  List<User>? replyUser;
  String? content;
  String? image;

  Post({
    this.postId,
    required this.owner,
    required this.userName,
    required this.profileUrl,
    required this.hours,
    this.liked,
    this.blueMarked,
    this.likeCount,
    this.replyUser,
    this.content,
    this.image,
  });

  Post.fromJson(String postId, {required Map<String, dynamic> json})
      : postId = postId ?? "",
        owner = json["owner"],
        userName = json["userName"],
        profileUrl = json["profileUrl"],
        liked = false,
        blueMarked = true,
        likeCount = 10,
        replyUser = [],
        content = json["content"] ?? "",
        hours = json["hours"],
        image = json["image"] ?? "";

  Map<String, dynamic> toJson() {
    return {
      "postId": postId ?? "",
      "owner": owner,
      "userName": userName,
      "profileUrl": profileUrl,
      "likeCount": likeCount ?? 0,
      "content": content ?? "",
      "hours": hours,
      "image": image ?? ""
    };
  }

  void printJson() {
    print("PRINT JSON : ${toJson()}");
  }
}
