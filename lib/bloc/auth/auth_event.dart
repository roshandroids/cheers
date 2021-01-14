part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;
  AuthLoginEvent({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

class AuthRegister extends AuthEvent {
  final String username;
  final String password;
  AuthRegister({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}
