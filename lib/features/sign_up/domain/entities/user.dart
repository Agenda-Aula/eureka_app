import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class User extends Equatable {
  final String email;
  final String displayName;

  User(this.email, this.displayName);

  @override
  // TODO: implement props
  List<Object> get props => [email, displayName];
}
