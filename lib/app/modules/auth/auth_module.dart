import 'package:dio/dio.dart';
import 'package:f1youtube/app/modules/auth/auth_controller.dart';
import 'package:f1youtube/app/modules/auth/auth_datasource.dart';
import 'package:f1youtube/app/modules/auth/auth_repository.dart';
import 'package:f1youtube/app/modules/auth/pages/sigin_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthenticationModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AuthDataSourceImpl(i.get<Dio>())),
        Bind((i) => AuthRepositoryImpl(i.get(), i.get())),
        Bind((i) => AuthControllerImpl(i.get()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/login', child: (context, args) => const LoginIn()),
      ];
}
