import 'package:f1youtube/app/modules/auth/auth_controller.dart';
import 'package:f1youtube/app/modules/auth/states/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/routes.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthControllerImpl _controller = Modular.get();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _listerners();
  }

  _listerners() {
    _controller.addListener(() {
      print(_controller.state);
      if (_controller.state is ErroSignUpState) {
        final message = _controller.state as ErroSignUpState;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.message),
        ));
        return;
      } else if (_controller.state is LoadingSignUpState) {
        setState(() {});
        return;
      } else if (_controller.state is LoadedSignUpState) {
        Modular.to.navigate(NamedRoutes.homeNotice);
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body = SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(children: [
          SvgPicture.asset(
            alignment: Alignment.center,
            color: Colors.white,
            height: 100,
            "assets/images/f1.svg",
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Email'),
            ),
          ),
          const SizedBox(
            height: 12,
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
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: true,
              controller: _password2Controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Confirm Password'),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Primeiro Nome'),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Segundo Nome'),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          TextButton(
            onPressed: () {
              Modular.to.navigate('/authentication/login');
            },
            child: const Text('Voltar para o Login'),
          ),
          GestureDetector(
            onTap: () => _controller.signup(
                _userNameController.text,
                _passwordController.text,
                _password2Controller.text,
                _emailController.text,
                _firstNameController.text,
                _lastNameController.text),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.indigo[700],
                ),
                child: const Center(child: Text('Cadastrar-se')),
              ),
            ),
          )
        ]),
      ),
    );
    if (_controller.state is LoadingSignUpState) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(body: body);
  }
}
