class HomeException implements Exception {
  final String message;
  HomeException(this.message);
}

class HomeFetchNoticesException implements HomeException {
  @override
  final String message;
  HomeFetchNoticesException(this.message);
}

class HomeFetchNoticeUnathorized implements HomeException {
  @override
  final String message;
  HomeFetchNoticeUnathorized(this.message);
}
