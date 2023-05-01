import 'package:f1youtube/app/modules/auth/states/login_state.dart';
import 'package:f1youtube/core/models/tokens.dart';
import 'package:flutter/foundation.dart';

import 'auth_repository.dart';

class AuthControllerImpl extends ChangeNotifier {
  final AuthRepositoryImpl _repository;
  AuthControllerImpl(this._repository);

  LoginState _state = StoppedLoginState();
  List<TokenModel> _tokens = [];

  LoginState get state => _state;
  List<TokenModel> get tokens => _tokens;

  login(String username, String password) async {
    _emit(LoadingLoginState());
    final result = await _repository.logIn(username, password);
    Future.delayed(const Duration(seconds: 5));
    result.fold((l) => {_emit(ErroLoginState(l.message))},
        (r) => {_tokens = r, _emit(LoadedLoginState())});
  }

  _emit(LoginState state) {
    _state = state;
    notifyListeners();
  }
}
