

import 'login_state.dart';

class StoppedSignUpState extends LoginState {}

class LoadingSignUpState extends LoginState {}

class LoadedSignUpState extends LoginState {}

class ErroSignUpState extends LoginState {
  final String message;

  ErroSignUpState(this.message);
}
