part of 'sign_up_user_bloc.dart';

abstract class SignUpUserEvent extends Equatable {
  const SignUpUserEvent();
}

class SignUpUser extends SignUpUserEvent {
  final Credential credential;

  SignUpUser({@required this.credential});

  @override
  List<Object> get props => [credential];
}
