part of 'sign_up_user_bloc.dart';

abstract class SignUpUserState extends Equatable {
  @override
  List<Object> get props => [];

  const SignUpUserState();
}

class Empty extends SignUpUserState {}

class Loading extends SignUpUserState {

}

class Loaded extends SignUpUserState {
  final String email;
  final String password;

  Loaded({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
