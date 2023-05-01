abstract class LoginState {}

class StoppedLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class LoadedLoginState extends LoginState {}

class ErroLoginState extends LoginState {
  final String message;

  ErroLoginState(this.message);
}
