import 'package:app/features/sign_up/domain/entities/register_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends User {
  final String email;
  final String displayName;

  UserModel({@required this.email, @required this.displayName})
      : super(email, displayName);

//  factory UserModel.mapFrom(FirebaseUser firebaseUser) {
//    return UserModel(
//        email: firebaseUser.email, displayName: firebaseUser.displayName);
//  }
}

extension UserModelMapper on UserModel {
  User get mapper => User(this.email, this.displayName);
}
