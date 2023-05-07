import 'package:f1youtube/app/modules/auth/auth_controller.dart';
import 'package:f1youtube/app/modules/auth/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/routes.dart';

class LoginInPage extends StatefulWidget {
  const LoginInPage({super.key});

  @override
  State<LoginInPage> createState() => _LoginInPageState();
}

class _LoginInPageState extends State<LoginInPage> {
  final AuthControllerImpl _controller = Modular.get<AuthControllerImpl>();
  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    _listerners();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _listerners() {
    print(_controller.state);
    _controller.addListener(() {
      if (_controller.state is ErroLoginState) {
        final message = _controller.state as ErroLoginState;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.message),
        ));
        return;
      } else if (_controller.state is LoadingLoginState) {
        setState(() {});
        return;
      } else if (_controller.state is LoadedLoginState) {
        Modular.to.navigate(NamedRoutes.homeNotice);
        return;
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_controller.state);
    Widget body = SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                alignment: Alignment.center,
                color: Colors.white,
                height: 200,
                "assets/images/f1.svg",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Usuário'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
              ),
              TextButton(
                onPressed: () {
                  Modular.to.pushNamed('/authentication/signup');
                },
                child: const Text('Criar uma conta'),
              ),
              GestureDetector(
                onTap: () => {
                  _controller.login(
                      _userNameController.text, _passwordController.text)
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.indigo[700],
                    ),
                    child: const Center(child: Text('Login-In')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (_controller.state is LoadingLoginState) {
      body = SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Expanded(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                alignment: Alignment.center,
                color: Colors.white,
                height: 200,
                "assets/images/f1.svg",
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Usuário'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
              ),
              TextButton(
                onPressed: () {
                  Modular.to.pushNamed('/authentication/signup');
                },
                child: const Text('Criar uma conta'),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.indigo[700],
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              )
            ]),
          ),
        ),
      );
    } else if (_controller.state is ErroLoginState) {
      body = SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Expanded(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                alignment: Alignment.center,
                color: Colors.white,
                height: 200,
                "assets/images/f1.svg",
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Usuário'),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
              ),
              TextButton(
                onPressed: () {
                  Modular.to.pushNamed('/authentication/signup');
                },
                child: const Text('Criar uma conta'),
              ),
              GestureDetector(
                onTap: () => _controller.login(
                    _userNameController.text, _passwordController.text),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.indigo[700],
                    ),
                    child: const Center(child: Text('LogIn')),
                  ),
                ),
              )
            ]),
          ),
        ),
      );
    } else if (_controller.state is LoadedLoginState) {
      Modular.to.navigate(NamedRoutes.homeNotice);
    }
    return Scaffold(
      body: body,
    );
  }
}
