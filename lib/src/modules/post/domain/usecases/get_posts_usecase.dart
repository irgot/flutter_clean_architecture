import 'package:clean_arquitecture/src/modules/post/domain/errors/post_errors.dart';
import 'package:clean_arquitecture/src/modules/post/domain/repositories/post_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/post.dart';

abstract class IGetPostsUsecase {
  Future<Either<IPostErrors, List<Post>>> call();
}

class GetPostsUsecase implements IGetPostsUsecase {
  final IPostRepository repository;

  GetPostsUsecase(this.repository);

  @override
  Future<Either<IPostErrors, List<Post>>> call() async {
    return await repository.getPosts();
  }
}
