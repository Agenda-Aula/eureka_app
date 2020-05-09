part of 'sign_up_page_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpUser extends SignUpEvent {
  final Credential credential;

  SignUpUser({@required this.credential});

  @override
  List<Object> get props => [credential];
}
