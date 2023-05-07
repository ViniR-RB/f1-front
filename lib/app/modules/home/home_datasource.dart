import 'dart:io';

import 'package:dio/dio.dart';
import 'package:f1youtube/core/models/tokens.dart';

import '../../../core/services/secure_storage.dart';

abstract class HomeDataSource {
  Future<Response> fetchNotices();
}

class HomeDataSourceImpl implements HomeDataSource {
  final Dio _dio;
  final SecureStorage _storage;
  HomeDataSourceImpl(this._dio, this._storage);

  @override
  Future<Response> fetchNotices() async {
    final tokens = TokenModel.fromMap(await _storage.readAll());
    final response = _dio.get('/notice/',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ${tokens.access}'
        }));
    return response;
  }
}
