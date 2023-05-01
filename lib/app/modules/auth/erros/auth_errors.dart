class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class LoginException implements AuthException {
  @override
  final String message;
  LoginException(this.message);
}
