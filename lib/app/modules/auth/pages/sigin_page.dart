import 'package:f1youtube/app/modules/auth/auth_controller.dart';
import 'package:f1youtube/app/modules/auth/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginIn extends StatefulWidget {
  const LoginIn({super.key});

  @override
  State<LoginIn> createState() => _LoginInState();
}

class _LoginInState extends State<LoginIn> {
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
    _listerners();
  }

  void _listerners() {
    _controller.addListener(() {
      if (_controller.state is ErroLoginState) {
        final message = _controller.state as ErroLoginState;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message.message),
        ));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_controller.state);
    Widget body = Container();
    if (_controller.state is StoppedLoginState) {
      body = Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          "F1 Mania",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
        )
      ]);
    } else if (_controller.state is LoadingLoginState) {
      body = Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          "F1 Mania",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
      ]);
    } else if (_controller.state is ErroLoginState) {
      body = Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          "F1 Mania",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
      ]);
    } else if (_controller.state is LoadedLoginState) {
      /* Modular.to.pushNamed(NamedRoutes.homeNotice); */
      body = Center(child: Text("${_controller.tokens.length}"));
    }
    return Scaffold(
      body: body,
    );
  }
}
