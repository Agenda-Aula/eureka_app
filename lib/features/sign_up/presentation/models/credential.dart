import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Credential extends Equatable {
  final String password;
  final String email;

  Credential({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}
