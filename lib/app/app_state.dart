abstract class AppState {}

class AppCheckTokenState extends AppState {}

class AppCheckTokenSucessState extends AppState {}

class AppCheckTokenInvalidState extends AppState {
  final String message;
  AppCheckTokenInvalidState(this.message);
}

class AppCheckTokenExpiredState extends AppState {
  final String message;
  AppCheckTokenExpiredState(this.message);
}
