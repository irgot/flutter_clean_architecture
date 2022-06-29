import 'package:clean_arquitecture/src/modules/post/data/adapters/user_adapter.dart';

import '../../domain/entities/post.dart';

class PostAdapter {
  PostAdapter._();
  static Post fromJson(dynamic data) {
    return Post(
        id: data['id'],
        text: data['text'],
        totalComments: data['totalComments'],
        user: UserAdapter.fromJson(data['user']));
  }
}
