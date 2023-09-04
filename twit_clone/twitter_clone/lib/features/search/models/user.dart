class User {
  final String name;
  final String profileUrl;
  final String userId;
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
}
