import 'package:clean_arquitecture/src/modules/post/domain/entities/comment.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/post.dart';
import '../errors/post_errors.dart';

abstract class IPostRepository {
  Future<Either<IPostErrors, List<Post>>> getPosts();
  Future<Either<IPostErrors, List<Comment>>> getPostComments(String postId);
}
