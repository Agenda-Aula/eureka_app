part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final Auth user;

  const Authenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthenticationState {}
