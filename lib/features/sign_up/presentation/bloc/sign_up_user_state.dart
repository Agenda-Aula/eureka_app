part of 'sign_up_user_bloc.dart';

abstract class SignUpUserState extends Equatable {
  const SignUpUserState();

  @override
  List<Object> get props => [];
}

class Empty extends SignUpUserState {}

class Loading extends SignUpUserState {}

class Loaded extends SignUpUserState {
  final User user;

  Loaded(this.user);

  @override
  List<Object> get props => [user];
}

class Error extends SignUpUserState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
