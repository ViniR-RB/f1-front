import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class AuthDatasource {
  Future<Response<dynamic>> logIn(String username, String password);
  Future<Response<dynamic>> signUp(String username, String password,
      String password2, String email, String firstName, String lastName);
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

  @override
  Future<Response<dynamic>> signUp(String username, String password,
      String password2, String email, String firstName, String lastName) async {
    final response = await dio.post(
      'api/register/',
      data: jsonEncode({
        "username": username,
        "password": password,
        "password2": password2,
        'email': email,
        "first_name": firstName,
        "last_name": lastName
      }),
      options:
          Options(headers: {HttpHeaders.contentTypeHeader: 'application/json'}),
    );
    return response;
  }
}
