import 'package:f1youtube/app/app_state.dart';
import 'package:f1youtube/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _controller = Modular.get<AppController>();
  _initial() async {
    await _controller.checkToken();

    Future.delayed(const Duration(seconds: 4));
  }

  void _listerners() {
    _controller.addListener(() {
      if (_controller.state is AppCheckTokenInvalidState ||
          _controller.state is AppCheckTokenExpiredState) {
        Modular.to.navigate(NamedRoutes.logIn);
        return;
      } else if (_controller.state is AppCheckTokenSucessState) {
        Modular.to.navigate(NamedRoutes.homeNotice);
        return;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _initial();
    _listerners();
  }

  @override
  void dispose() {
    _listerners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(color: Colors.black),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/images/background.jpeg',
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SvgPicture.asset(
              alignment: Alignment.center,
              color: Colors.white,
              "assets/images/f1.svg",
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 32),
              child: const CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
            const Text(
              "Desenvolvido por Vinicius Roosevelt",
              style: TextStyle(shadows: <Shadow>[
                Shadow(
                  offset: Offset(0, 0),
                  color: Colors.black,
                ),
              ], color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        )
      ],
    ));
  }
}
