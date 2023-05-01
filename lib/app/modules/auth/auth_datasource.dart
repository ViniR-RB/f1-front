import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class AuthDatasource {
  Future<Response<dynamic>> logIn(String username, String password);
}

class AuthDataSourceImpl implements AuthDatasource {
  Dio dio;
  AuthDataSourceImpl(this.dio);

  @override
  Future<Response<dynamic>> logIn(String username, String password) async {
    final response = await dio.post(
      "/api/token/",
      data: jsonEncode({"username": username, "password": password}),
      options:
          Options(headers: {HttpHeaders.contentTypeHeader: 'application/json'}),
    );
    return response;
  }
}
