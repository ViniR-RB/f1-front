import 'package:f1youtube/app/app_state.dart';
import 'package:flutter/foundation.dart';

import 'app_repository.dart';
import 'erros/app_erros.dart';

class AppController extends ChangeNotifier {
  final AppRepository _repository;
  AppState _state = AppCheckTokenState();
  AppState get state => _state;
  AppController(this._repository);
  checkToken() async {
    final result = await _repository.checkToken();
     result.fold(
        (l) => {
              if (l is AppTokenException)
                {_emit(AppCheckTokenInvalidState(l.message))}
              else if (l is AppTokenExpiredException)
                {_emit(AppCheckTokenExpiredState(l.message))}
            },
        (r) => {
          _emit(AppCheckTokenSucessState())
        });
  }

  _emit(AppState state) {
    _state = state;
    notifyListeners();
  }
}
