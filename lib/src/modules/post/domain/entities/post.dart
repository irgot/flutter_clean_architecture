import 'package:clean_arquitecture/src/modules/post/domain/entities/user.dart';

class Post {
  final String id;
  final User user;
  final String text;
  final int totalComments;

  Post({
    required this.id,
    required this.user,
    required this.text,
    required this.totalComments,
  });
}
