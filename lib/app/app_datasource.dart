import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class AppDataSource {
  Future<Response<dynamic>> checkToken(String refresh);
}

class AppDataSourceImpl implements AppDataSource {
  final Dio _dio;
  AppDataSourceImpl(this._dio);

  @override
  Future<Response> checkToken(String refresh) async {
    final response = await _dio.post('/api/token/refresh/',
        data: jsonEncode({"refresh": refresh}),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: 'application/json'}));
    return response;
  }
}
