import 'package:app/features/auth/domain/entities/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserAuthModel extends UserAuth {
  final String email;
  final String displayName;

  UserAuthModel({@required this.email, @required this.displayName})
      : super(email, displayName);

  factory UserAuthModel.mapFrom(FirebaseUser firebaseUser) {
    return UserAuthModel(
        email: firebaseUser.email, displayName: firebaseUser.displayName);
  }
}
