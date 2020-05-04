import 'package:app/core/error/Failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class SignUpValidator {
  Either<Failure, String> validateEmail(String str) {
    var errorMessage = '';
    if (_isNotEmptyEmail(str)) {
      errorMessage = 'Email is empty';
    } else if (_isValidEmail(str)) {
      errorMessage = 'Email is not valid';
    }
    return _isNotEmptyEmail(str) && _isValidEmail(str)
        ? Right(str)
        : Left(InvalidEmail(message: errorMessage));
  }

  Either<Failure, String> validatePassword(String str) {
    if (_isValidPassword(str)) {
      return Right(str);
    }
    return Left(InvalidEmail(message: 'Password is too short'));
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

  bool _isNotEmptyEmail(String str) => str.isNotEmpty;
}

class InvalidEmail extends Failure {
  final String message;

  InvalidEmail({@required this.message});
}
