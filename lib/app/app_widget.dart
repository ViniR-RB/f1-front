import 'package:flutter/material.dart';

import '../core/constants/routes.dart';
import '../core/themes/default_themes.dart';
import 'modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      initialRoute: NamedRoutes.initial,
      debugShowCheckedModeBanner: false,
      routes: {
        NamedRoutes.initial: (context) => const SplashPage(),
      },
    );
  }
}
