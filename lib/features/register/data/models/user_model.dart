import 'package:app/features/sign_up/domain/entities/user.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends User {
  final String email;
  final String displayName;

  UserModel({@required this.email, @required this.displayName})
      : super(email, displayName);
}

extension UserModelMapper on UserModel {
  User get mapper => User(this.email, this.displayName);
}
