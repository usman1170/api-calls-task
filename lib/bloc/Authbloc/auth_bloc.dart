import 'dart:developer';

import 'package:api_calls/repository/auth_repository.dart';
import 'package:api_calls/utils/emuns.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ApiRepository authRepository = ApiRepository();
  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>(_login);
  }
  void _login(LoginEvent event, emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    Map data = {
      "username": event.email,
      "password": event.password,
      "expiresInMins": 30
    };
    await authRepository.login(data).then((value) {
      log("Success");
      emit(state.copyWith(authStatus: AuthStatus.success));
    }).onError(
      (error, stackTrace) {
        emit(state.copyWith(msg: error.toString()));
        log("Error in Auth Bloc Login = $error");
        emit(state.copyWith(authStatus: AuthStatus.failed));
      },
    );
  }
}
