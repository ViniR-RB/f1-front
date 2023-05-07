import 'package:f1youtube/app/modules/home/home_controller.dart';
import 'package:f1youtube/app/modules/home/home_datasource.dart';
import 'package:f1youtube/app/modules/home/home_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<HomeDataSource>((i) => HomeDataSourceImpl(i.get(), i.get())),
        Bind<HomeRepository>((i) => HomeRepositoryImpl(i.get(), i.get())),
        Bind((i) => HomeController(i.get())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => const HomePage()),
      ];
}
