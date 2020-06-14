
import 'package:app/features/authentication/domain/entities/user.dart';
import 'package:flutter/foundation.dart';

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
