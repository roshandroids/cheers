import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthLoginEvent) {
      yield AuthLoadingState();

      final user =
          await Future.delayed(Duration(seconds: 10)).then((value) => "hello");

      if (user != null) {
        yield AuthLoggedInState(
          isLoggedIn: true,
          message: "Success",
        );
      } else {
        yield AuthErrorState(isFailed: true, message: "Something wrong!");
      }
    }
  }
}
