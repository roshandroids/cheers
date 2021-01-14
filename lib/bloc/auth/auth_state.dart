part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoggedInState extends AuthState {
  final bool isLoggedIn;
  final String message;
  AuthLoggedInState({
    this.isLoggedIn,
    this.message,
  });
  @override
  List<Object> get props => [isLoggedIn, message];
}

class AuthRegisteredState extends AuthState {
  final bool registered;
  final String message;
  AuthRegisteredState({
    this.registered,
    this.message,
  });
  @override
  List<Object> get props => [registered, message];
}

class AuthErrorState extends AuthState {
  final bool isFailed;
  final String message;
  AuthErrorState({
    this.isFailed,
    this.message,
  });
  @override
  List<Object> get props => [isFailed, message];
}
