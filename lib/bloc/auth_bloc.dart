import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:lenovo_app/services/auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckUsername>((event, emit) => _checkUserNameFun(event, emit));
    on<AuthPasswordLogin>(_passwordLogin);
    on<AuthGenerateOtp>(_generateOtp);
    on<AuthOtpLogin>(_otpLogin);
  }

  _checkUserNameFun(AuthCheckUsername event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    Map<String, dynamic> res =
        await AuthServices().checkUserValidFun(event.param);
    if (res['status'] == "SUCCESS") {
      emit(AuthUserNameVerified());
    } else {
      emit(AuthInvalidUser());
    }
  }

  _passwordLogin(AuthPasswordLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    var res = jsonDecode(await AuthServices().loginFun(event.param));
    if (res['status'] == "SUCCESS") {
      emit(AuthLoginSuccessfully(res));
    } else {
      emit(AuthInvalidPassword());
    }
  }

  _generateOtp(AuthGenerateOtp event, Emitter<AuthState> emit) async {
    emit(AuthOtpLoading());
    var res = jsonDecode(await AuthServices().generateOtp(event.param));
    if (res['status'] == "SUCCESS") {
      emit(AuthUserNameVerified());

      emit(OtpSent(res));
    } else {
      emit(AuthInvalidOtp());
    }
  }

  _otpLogin(AuthOtpLogin event, Emitter<AuthState> emit) async {
    emit(AuthOtpLoading());
    var res = jsonDecode(await AuthServices().loginFun(event.param));
    if (res['status'] == "SUCCESS") {
      emit(OtpVerified(res));
    } else {
      emit(AuthInvalidOtp());
    }
  }
}
