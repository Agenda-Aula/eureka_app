import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class User extends Equatable {
  final String email;
  final String displayName;
  final String profileUrl;

  User(this.email, this.displayName, this.profileUrl);

  @override
  List<Object> get props => [email, displayName];
}
