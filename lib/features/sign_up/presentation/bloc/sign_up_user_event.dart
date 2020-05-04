part of 'sign_up_user_bloc.dart';

abstract class SignUpUserEvent extends Equatable {
  const SignUpUserEvent();
}

class SignUpUser extends SignUpUserEvent {
  final String email;
  final String password;

  SignUpUser({this.email, this.password});

  @override
  List<Object> get props => [email, password];
}
