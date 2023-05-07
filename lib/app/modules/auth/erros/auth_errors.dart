class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class LoginException implements AuthException {
  @override
  final String message;
  LoginException(this.message);
}


class SignUpException implements AuthException {
   @override
  final String message;
  SignUpException(this.message);
}