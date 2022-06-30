import 'package:clean_arquitecture/src/modules/post/data/datasources/post_datasource.dart';
import 'package:clean_arquitecture/src/modules/post/domain/errors/post_errors.dart';
import 'package:dio/dio.dart';

class PostDatasource implements IPostDatasource {
  final Dio dio;

  PostDatasource(this.dio);
  @override
  Future<List> getPosts() async {
    try {
      final response = await dio.get('http://192.168.15.26:3000/posts');
      return response.data;
    } catch (e, s) {
      throw DataSourceException(message: e.toString(), stackTrace: s);
    }
  }
}
