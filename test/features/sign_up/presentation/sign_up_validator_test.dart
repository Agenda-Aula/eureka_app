import 'package:app/features/sign_up/presentation/sign_up_validator.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SignUpValidator validator;
  setUp(() {
    validator = SignUpValidator();
  });

  group('signUpValidator', () {
    test('should return a valid password', () async {
      final passwordValid = "Pass!qwert";
      final result = validator.validatePassword(passwordValid);
      expect(result, Right(passwordValid));
    });
    test('should return a valid email', () async {
      final validEmail = "douglas@gmail.com";
      final result = validator.validateEmail(validEmail);
      expect(result, Right(validEmail));
    });
    test('should return a message email is empty', () async {
      final invalidEmail = "asdfasd@";
      final messageError = 'Email is empty';
      final result = validator.validateEmail(invalidEmail);
      expect(result, Left(InvalidEmail(message: messageError)));
    });
    test('should return a message email is not valid', () async {
      final invalidEmail = "asdfasd@";
      final messageError = 'Email is not valid';
      final result = validator.validateEmail(invalidEmail);
      expect(result, Left(InvalidEmail(message: messageError)));
    });

    test('should return a message password is too short', () async {
      final passwordValid = "Pass";
      final messageError = 'Password is too short';
      final result = validator.validatePassword(passwordValid);
      expect(result, Left(InvalidEmail(message: messageError)));
    });
  });
}
