class AppException implements Exception {
  final String message;
  AppException(this.message);
}

class AppTokenExpiredException implements AppException {
  @override
  final String message;
  AppTokenExpiredException(this.message);
}

class AppTokenException implements AppException {
  @override
  final String message;
  AppTokenException(this.message);
}
