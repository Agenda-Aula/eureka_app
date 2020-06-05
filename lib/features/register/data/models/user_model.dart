import 'package:app/features/register/domain/entitties/user.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends User {
  final String email;
  final String profileUrl;
  final String displayName;

  UserModel(
      {@required this.email,
      @required this.profileUrl,
      @required this.displayName})
      : super(email, displayName, profileUrl);
}

extension UserModelMapper on UserModel {
  User get mapper => User(this.email, this.displayName, this.profileUrl);
}
