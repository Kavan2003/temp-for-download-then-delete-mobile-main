part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoginLoading extends AuthState {}

class AuthOtpLoading extends AuthState {}

class AuthUserNameVerified extends AuthState {}

class AuthInvalidUser extends AuthState {}

class AuthInvalidPassword extends AuthState {}

class AuthInvalidOtp extends AuthState {}

class AuthError extends AuthState {
  final Map<String, dynamic> param;

  AuthError(this.param);
}

class AuthLoginSuccessfully extends AuthState {
  final Map<String, dynamic> param;

  AuthLoginSuccessfully(this.param);
}

class OtpSent extends AuthState {
  final Map<String, dynamic> param;

  OtpSent(this.param);
}

class OtpVerified extends AuthState {
  final Map<String, dynamic> param;

  OtpVerified(this.param);
}
