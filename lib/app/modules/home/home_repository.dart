import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:f1youtube/app/modules/home/home_datasource.dart';
import 'package:f1youtube/core/services/secure_storage.dart';

import '../../../core/models/notice.dart';
import 'erros/home_erros.dart';

abstract class HomeRepository {
  Future<Either<HomeException, List<NoticeModel>>> fetchNotices();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource _dataSource;
  final SecureStorage _storage;
  HomeRepositoryImpl(this._dataSource, this._storage);

  @override
  Future<Either<HomeException, List<NoticeModel>>> fetchNotices() async {
    try {
      final response = await _dataSource.fetchNotices();
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final notices = data.map((e) => NoticeModel.fromMap(e)).toList();

        return Right(notices);
      } else if (response.statusCode == 401) {
        return Left(HomeFetchNoticeUnathorized('Você não possuí autorização'));
      } else {
        return Left(HomeException('Houve um erro inesperado'));
      }
    } on DioError catch (e) {
      if (e.response!.data["code"] == 'user_not_found') {
        _storage.delete("acess");
        _storage.delete("refresh");
      }
      return Left(
          HomeException('Houve um erro em fazer a busca pelas noticias'));
    } catch (e) {
      return Left(HomeException('Houve um erro inesperado'));
    }
  }
}
