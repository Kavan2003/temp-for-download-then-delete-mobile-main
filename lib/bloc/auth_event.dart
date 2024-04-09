part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthCheckUsername extends AuthEvent {
  final Map<String, dynamic> param;

  AuthCheckUsername(this.param);
}

class AuthGenerateOtp extends AuthEvent {
  final Map<String, dynamic> param;

  AuthGenerateOtp(this.param);
}

class AuthPasswordLogin extends AuthEvent {
  final Map<String, dynamic> param;

  AuthPasswordLogin(this.param);
}

class AuthOtpLogin extends AuthEvent {
  final Map<String, dynamic> param;

  AuthOtpLogin(this.param);
}
