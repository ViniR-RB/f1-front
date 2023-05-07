import 'package:dartz/dartz.dart';
import 'package:f1youtube/app/erros/app_erros.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../core/models/tokens.dart';
import '../core/services/secure_storage.dart';
import 'app_datasource.dart';

abstract class AppRepository {
  Future<Either<AppException, List<TokenModel>>> checkToken();
}

class AppRepositoryImpl implements AppRepository {
  final AppDataSource _dataSource;
  final SecureStorage _storage;
  AppRepositoryImpl(this._dataSource, this._storage);

  @override
  Future<Either<AppException, List<TokenModel>>> checkToken() async {
    try {
      final tokens = TokenModel.fromMap(await _storage.readAll());
      final refresh = Jwt.parseJwt(tokens.refresh);
      var now = (DateTime.now().millisecondsSinceEpoch / 1000).round();
      if (now > refresh['exp']) {
        return Left(AppTokenExpiredException('Token Expirado'));
      } else {
        final response = await _dataSource.checkToken(tokens.refresh);
        if (response.statusCode == 200) {
          final data = response.data;
          final newtokens = TokenModel.fromMap(data);
          _storage.write('access', newtokens.access);
          _storage.write('refresh', newtokens.refresh);
          return Right([newtokens]);
        } else {
          return Left(AppTokenException('Token Expirado'));
        }
      }
    } catch (e) {
      return Left(AppTokenException('Houve um Problema com o token'));
    }
  }
}
