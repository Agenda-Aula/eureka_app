part of 'sign_up_page_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class Empty extends SignUpState {}

class Loading extends SignUpState {}

class Loaded extends SignUpState {
  final User user;

  Loaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class Error extends SignUpState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
