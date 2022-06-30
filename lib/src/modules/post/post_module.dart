import 'package:clean_arquitecture/src/modules/post/data/datasources/comment_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/data/datasources/post_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/data/datasources/user_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/data/repositories/post_repository_data.dart';
import 'package:clean_arquitecture/src/modules/post/domain/repositories/post_repository.dart';
import 'package:clean_arquitecture/src/modules/post/domain/usecases/get_post_comments_usecase.dart';
import 'package:clean_arquitecture/src/modules/post/domain/usecases/get_posts_usecase.dart';
import 'package:clean_arquitecture/src/modules/post/external/datasources/comment_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/external/datasources/post_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/presenter/pages/post_page.dart';
import 'package:clean_arquitecture/src/modules/post/presenter/stores/post_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'external/datasources/user_datasource.dart';

class PostModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.factory((i) => Dio()),
        Bind.factory<IPostDatasource>((i) => PostDatasource(i())),
        Bind.factory<ICommentDatasource>((i) => CommentDatasource(i())),
        Bind.factory<IUserDatasource>((i) => UserDatasource(i())),
        Bind.factory<IPostRepository>((i) => PostRepositoryData(i(), i(), i())),
        Bind.factory((i) => GetPostsUsecase(i())),
        Bind.factory((i) => GetPostCommentUsecase(i())),
        Bind.singleton((i) => PostStore(i())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: ((context, args) => PostPage()),
        ),
      ];
}
