import 'package:f1youtube/core/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  _initial() {
    Future.delayed(const Duration(seconds: 2));
    Modular.to.pushNamed(NamedRoutes.logIn);
  }

  @override
  void initState() {
    super.initState();
    _initial();
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
                "assets/images/f1.svg"),
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
