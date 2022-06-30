import 'package:clean_arquitecture/src/modules/post/data/datasources/user_datasource.dart';
import 'package:dio/dio.dart';

import '../../domain/errors/post_errors.dart';

class UserDatasource implements IUserDatasource {
  final Dio dio;

  UserDatasource(this.dio);

  @override
  Future<List> getUsers() async {
    try {
      final response = await dio.get("http://192.168.15.26:3000/users");
      return response.data;
    } catch (e, s) {
      throw DataSourceException(message: e.toString(), stackTrace: s);
    }
  }
}
