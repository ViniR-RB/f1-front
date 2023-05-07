import 'package:f1youtube/core/models/notice.dart';

class HomeState {}

class HomeLoadignState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<NoticeModel> notice;
  HomeLoadedState(this.notice);
}

class HomeExceptionState extends HomeState {
  final String message;
  HomeExceptionState(this.message);
}

class HomeFetchExceptionState extends HomeState {
  final String message;
  HomeFetchExceptionState(this.message);
}

class HomeUnathorizedState extends HomeState {
  final String message;
  HomeUnathorizedState(this.message);
}
