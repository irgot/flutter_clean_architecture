import 'package:clean_arquitecture/src/modules/post/data/datasources/comment_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/domain/errors/post_errors.dart';
import 'package:dio/dio.dart';

class CommentDatasource implements ICommentDatasource {
  final Dio dio;

  CommentDatasource(this.dio);
  @override
  Future<List> getComments() async {
    try {
      final response = await dio.get('http://192.168.15.26:3000/comments');
      return response.data;
    } catch (e, s) {
      throw DataSourceException(message: e.toString(), stackTrace: s);
    }
  }
}
