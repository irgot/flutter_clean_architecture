import 'package:clean_arquitecture/src/modules/post/domain/entities/comment.dart';
import 'package:clean_arquitecture/src/modules/post/domain/errors/post_errors.dart';
import 'package:clean_arquitecture/src/modules/post/domain/repositories/post_repository.dart';
import 'package:clean_arquitecture/src/modules/post/domain/usecases/get_post_comments_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class PostRepositoryMock extends Mock implements IPostRepository {}

void main() {
  final repository = PostRepositoryMock();
  final usecase = GetPostCommentUsecase(repository);
  test('deve retornar uma lista de comentarios', () async {
    when(() => repository.getPostComments('1'))
        .thenAnswer((_) async => right([]));
    final result = await usecase('1');
    expect(result.fold(id, id), isA<List<Comment>>());
  });
  test('deve retornar um ArgumentError se o parâmetro for vazio', () async {
    final result = await usecase('');
    expect(result.fold(id, id), isA<ArgumentsException>());
  });
}
