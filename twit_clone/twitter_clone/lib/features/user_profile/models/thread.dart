import 'package:twitter_clone/features/search/models/user.dart';

import '../../home/models/post.dart';

class Thread {
  final String comment;
  final User user;
  final String hour;
  Post? post;
  Thread({
    required this.user,
    required this.comment,
    required this.hour,
    this.post,
  });
}
