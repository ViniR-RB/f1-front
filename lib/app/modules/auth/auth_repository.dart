import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:f1youtube/app/modules/auth/erros/auth_errors.dart';
import 'package:f1youtube/core/models/tokens.dart';
import 'package:f1youtube/core/services/secure_storage.dart';

import 'auth_datasource.dart';

class AuthRepositoryImpl {
  final AuthDatasource _datasource;
  final SecureStorage _storage;
  AuthRepositoryImpl(this._datasource, this._storage);
  Future<Either<AuthException, List<TokenModel>>> logIn(
      String username, String password) async {
    try {
      final response = await _datasource.logIn(username, password);
      if (response.statusCode == 200) {
        final data = response.data;
        final tokens = [TokenModel.fromMap(data)];

        return Right(tokens);
      } else {
        return Left(LoginException("Usuário e/ou senha incorreto(s)"));
      }
    } on DioError catch (e) {
      print(e);
      return Left(
          LoginException(e.message ?? "Usuário e/ou senha incorreto(s)"));
    } catch (e) {
      return Left(LoginException("Usuário e/ou senha incorreto(s)"));
    }
  }
}
