import 'package:f1youtube/app/modules/home/erros/home_erros.dart';
import 'package:f1youtube/app/modules/home/home_repository.dart';
import 'package:f1youtube/app/modules/home/states/home_state.dart';
import 'package:flutter/foundation.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository _repository;
  HomeState _state = HomeLoadignState();
  HomeState get state => _state;
  HomeController(this._repository);

  fetchNotices() async {
    _emit(HomeLoadignState());
    final result = await _repository.fetchNotices();
    result.fold(
        (l) => {
              if (l is HomeFetchNoticesException)
                {_emit(HomeFetchExceptionState(l.message))}
              else if (l is HomeFetchNoticeUnathorized)
                {_emit(HomeUnathorizedState(l.message))}
              else
                {_emit(HomeExceptionState(l.message))}
            },
        (r) => {_emit(HomeLoadedState(r))});
  }

  _emit(HomeState state) {
    _state = state;
    notifyListeners();
  }
}
