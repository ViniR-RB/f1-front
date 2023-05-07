import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:f1youtube/app/modules/auth/erros/auth_errors.dart';
import 'package:f1youtube/core/models/tokens.dart';
import 'package:f1youtube/core/services/secure_storage.dart';

import 'auth_datasource.dart';

abstract class AuthRepository {
  Future<Either<AuthException, List<TokenModel>>> logIn(
      String username, String password);
  Future<Either<AuthException, List<TokenModel>>> signUp(
      String username,
      String password,
      String password2,
      String email,
      String firstName,
      String lastName);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;
  final SecureStorage _storage;
  AuthRepositoryImpl(this._datasource, this._storage);
  @override
  Future<Either<AuthException, List<TokenModel>>> logIn(
      String username, String password) async {
    try {
      final response = await _datasource.logIn(username, password);
      if (response.statusCode == 200) {
        final data = response.data;
        final tokens = TokenModel.fromMap(data);
        _storage.write('access', tokens.access);
        _storage.write('refresh', tokens.refresh);
        return Right([tokens]);
      } else {
        return Left(LoginException("Usuário e/ou senha incorreto(s)"));
      }
    } on DioError catch (e) {
      return Left(
          LoginException(e.message ?? "Usuário e/ou senha incorreto(s)"));
    } catch (e) {
      return Left(LoginException("Usuário e/ou senha incorreto(s)"));
    }
  }

  @override
  Future<Either<AuthException, List<TokenModel>>> signUp(
      String username,
      String password,
      String password2,
      String email,
      String firstName,
      String lastName) async {
    try {
      final response = await _datasource.signUp(
          username, password, password2, email, firstName, lastName);
      if (response.statusCode == 201) {
        final result = await logIn(username, password);
        return result.fold((l) => Left(l), (r) => Right(r));
      } else {
        return Left(SignUpException('Houve algum erro em Fazer o Cadastro'));
      }
    } on DioError catch (e) {
      print(e);
      return Left(SignUpException('Email ou e Username já estão em uso'));
    } catch (e) {
      return Left(SignUpException('Email ou e Username já estão em uso'));
    }
  }
}
