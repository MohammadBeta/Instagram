abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFauiler extends AuthState {
  final String errorMessage;
  LoginFauiler({required this.errorMessage});
}


class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpFauiler extends AuthState {
  final String errorMessage;
  SignUpFauiler({required this.errorMessage});
}
