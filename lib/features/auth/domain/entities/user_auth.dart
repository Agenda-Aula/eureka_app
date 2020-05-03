import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UserAuth extends Equatable {
  final String email;
  final String displayName;

  UserAuth(this.email, this.displayName);

  @override
  List<Object> get props => [email, displayName];
}
