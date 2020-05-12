import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class EmailChanged extends RegisterEvent {
  final String email;

  EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => "Email: $email";
}

class PasswordChanged extends RegisterEvent {
  final String password;

  PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => "Password:####";
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;

  const Submitted({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}
