class User {
  String name;
  String profileUrl;
  String userId;
  String? subTitle;
  String? repFollowerProfileUrl; // 대표팔로워의 프로필 url
  String? followCount; // 팔로우수

  User(
      {required this.name,
      required this.profileUrl,
      required this.userId,
      this.subTitle,
      this.repFollowerProfileUrl,
      this.followCount});

  User.fromJson({required Map<String, dynamic> json})
      : name = json["name"] ?? "",
        profileUrl = json["profileUrl"] ?? "",
        userId = json["userId"],
        subTitle = json["subTitle"],
        repFollowerProfileUrl = json["repFollowerProfileUrl"],
        followCount = json["followCount"];
}
