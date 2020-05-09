import 'package:app/core/error/Failure.dart';
import 'package:app/features/sign_up/presentation/models/credential.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'bloc/sign_up_page_bloc.dart';

class SignUpValidator {
  Either<Failure, Credential> validateCredential(Credential credential) {
    final emailValidated = _isValidEmail(credential.email);
    final pwValidated = _isValidPassword(credential.password);
    if (!pwValidated) {
      return Left(InvalidEmail(message: INVALID_INPUT_PASSWORD));
    }
    if (!emailValidated) {
      return Left(InvalidEmail(message: INVALID_INPUT_EMAIL));
    }
    return Right(credential);
  }

  bool _isValidPassword(String str) {
    final expectedLength = 6;
    return str.length >= expectedLength ?? false;
  }

  bool _isValidEmail(String str) {
    final bool emailValidPattern = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(str);
    return emailValidPattern ?? false;
  }
}

class InvalidEmail extends Failure {
  final String message;

  InvalidEmail({@required this.message});
}
