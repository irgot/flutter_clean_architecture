import 'dart:convert';

import 'package:clean_arquitecture/src/modules/post/data/datasources/comment_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/data/datasources/post_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/data/datasources/user_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/data/repositories/post_repository_data.dart';
import 'package:clean_arquitecture/src/modules/post/domain/entities/comment.dart';
import 'package:clean_arquitecture/src/modules/post/domain/entities/post.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class UserDatasourceMock extends Mock implements IUserDatasource {}

class PostDatasourceMock extends Mock implements IPostDatasource {}

class CommentDatasourceMock extends Mock implements ICommentDatasource {}

void main() {
  final IUserDatasource userDatasource = UserDatasourceMock();
  final IPostDatasource postDatasource = PostDatasourceMock();
  final ICommentDatasource commentDatasource = CommentDatasourceMock();
  final repository =
      PostRepositoryData(userDatasource, commentDatasource, postDatasource);

  test("get posts", () async {
    when(() => userDatasource.getUsers())
        .thenAnswer((invocation) async => usersJson);
    when(() => postDatasource.getPosts())
        .thenAnswer((invocation) async => postsJson);
    when(() => commentDatasource.getComments())
        .thenAnswer((invocation) async => commentsJson);
    final result = await repository.getPosts();

    final list = result.fold(id, id);
    expect(list, isA<List<Post>>());
    expect((list as List).length, 3);
    expect((list as List).first.id, "0");
    expect((list as List).first.totalComments, 3);
  });
  test("get comments", () async {
    when(() => userDatasource.getUsers())
        .thenAnswer((invocation) async => usersJson);
    when(() => postDatasource.getPosts())
        .thenAnswer((invocation) async => postsJson);
    when(() => commentDatasource.getComments())
        .thenAnswer((invocation) async => commentsJson);
    final result = await repository.getPostComments('0');

    final list = result.fold(id, id);
    expect(list, isA<List<Comment>>());
    expect((list as List).length, 3);
  });
}

final usersJson = jsonDecode(
    """
[
  {
    "id": "0",
    "name": "Robert",
    "avatar": {
      "url": "https://static1.conquistesuavida.com.br/articles//4/56/84/@/18399-as-pessoas-sensiveis-tem-por-caracteris-article_gallery_large-3.jpg"
    }
  },
  {
    "id": "1",
    "name": "Carls",
    "avatar": {
      "url": "https://www.familia.com.br/wp-content/uploads/2019/12/Pessoas-felizes-n%C3%A3o-t%C3%AAm-tempo-para-criticar-a-vida-dos-outros.jpg"
    }
  }
]
""");

final commentsJson = jsonDecode(
    """
[
  {
    "id": "0",
    "postId": "0",
    "text": "Hello"
  },
  {
    "id": "1",
    "postId": "0",
    "text": "Hi"
  },
  {
    "id": "2",
    "postId": "0",
    "text": "Hi!"
  },
  {
    "id": "3",
    "postId": "1",
    "text": "Hi"
  },
  {
    "id": "4",
    "postId": "1",
    "text": "Hi!"
  }
]

""");

final postsJson = jsonDecode(
    """
[
  {
    "id": "0",
    "userId": "0",
    "text": "Coisas legais sobre o Flutter que devemos saber mas a gente n??o sabe pq tem pregui??a de estudar"
  },
  {
    "id": "1",
    "userId": "1",
    "text": "Coisas legais sobre o Flutter que devemos saber mas a gente n??o sabe pq tem pregui??a de estudar"
  },
  {
    "id": "2",
    "userId": "0",
    "text": "Eu sinceramente n??o gosto de android studio, por favor, utilizem o VSCode, OBRIGADO!"
  }
]
""");
