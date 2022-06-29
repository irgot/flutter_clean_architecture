import 'package:clean_arquitecture/src/modules/post/domain/errors/post_errors.dart';
import 'package:clean_arquitecture/src/modules/post/domain/repositories/post_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/comment.dart';

abstract class IGetPostCommentsUsecase {
  Future<Either<IPostErrors, List<Comment>>> call(String postId);
}

class GetPostCommentUsecase implements IGetPostCommentsUsecase {
  final IPostRepository repository;

  GetPostCommentUsecase(this.repository);
  @override
  Future<Either<IPostErrors, List<Comment>>> call(String postId) async {
    if (postId.isEmpty) {
      return left(ArgumentsException(message: "postId is empty"));
    }
    return await repository.getPostComments(postId);
  }
}
