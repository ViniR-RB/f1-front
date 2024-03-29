import 'package:dio/dio.dart';
import 'package:f1youtube/app/app_controller.dart';
import 'package:f1youtube/app/app_datasource.dart';
import 'package:f1youtube/app/app_repository.dart';
import 'package:f1youtube/app/modules/auth/auth_module.dart';
import 'package:f1youtube/app/modules/splash/splash_page.dart';
import 'package:f1youtube/core/constants/configurations.dart';
import 'package:f1youtube/core/constants/routes.dart';
import 'package:f1youtube/core/services/secure_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<AppDataSource>((i) => AppDataSourceImpl(i.get())),
        Bind<AppRepository>((i) => AppRepositoryImpl(i.get(), i.get())),
        Bind((i) => AppController(i.get<AppRepository>())),
        Bind.singleton((i) => SecureStorage()),
        Bind.lazySingleton<Dio>(
            (i) => Dio(BaseOptions(baseUrl: ConfigurationEnv.baseUrl)))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(NamedRoutes.initial,
            child: (context, args) => const SplashPage()),
        ModuleRoute(NamedModuleRoutes.authentication,
            module: AuthenticationModule()),
        ModuleRoute(NamedModuleRoutes.home, module: HomeModule()),
      ];
}
