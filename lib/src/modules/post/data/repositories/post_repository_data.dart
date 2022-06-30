import 'package:clean_arquitecture/src/modules/post/data/adapters/comment_adapter.dart';
import 'package:clean_arquitecture/src/modules/post/data/adapters/post_adapter.dart';
import 'package:clean_arquitecture/src/modules/post/data/datasources/comment_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/data/datasources/post_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/data/datasources/user_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/domain/errors/post_errors.dart';
import 'package:clean_arquitecture/src/modules/post/domain/entities/post.dart';
import 'package:clean_arquitecture/src/modules/post/domain/entities/comment.dart';
import 'package:clean_arquitecture/src/modules/post/domain/repositories/post_repository.dart';
import 'package:fpdart/src/either.dart';

class PostRepositoryData extends IPostRepository {
  final IUserDatasource userDatasource;
  final ICommentDatasource commentDatasource;
  final IPostDatasource postDatasource;

  PostRepositoryData(
      this.userDatasource, this.commentDatasource, this.postDatasource);

  @override
  Future<Either<IPostErrors, List<Comment>>> getPostComments(
      String postId) async {
    try {
      final list = await commentDatasource.getComments();
      final comments = list
          .where((element) => element['postId'] == postId)
          .map(CommentAdapter.fromJson)
          .toList();
      return right(comments);
    } on IPostErrors catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<IPostErrors, List<Post>>> getPosts() async {
    try {
      final listComments = await commentDatasource.getComments();
      final listUsers = await userDatasource.getUsers();
      final listPosts = await postDatasource.getPosts();

      final map = <String, int>{};
      for (var comment in listComments) {
        map.putIfAbsent(comment['postId'], () => 0);
        map[comment['postId']] = map[comment['postId']]! + 1;
      }
      for (var user in listUsers) {
        for (var post in listPosts) {
          if (user['id'] == post['userId']) {
            post['user'] = user;
          }
          post['totalComments'] = map[post['id']] ?? 0;
        }
      }
      final posts = listPosts.map(PostAdapter.fromJson).toList();
      return right(posts);
    } on IPostErrors catch (e) {
      return left(e);
    }
  }
}
