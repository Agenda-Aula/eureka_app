import 'package:app/features/sign_up/presentation/models/credential.dart';
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
      final credential = Credential('douglas@gmail.com', '123456');
      final result = validator.validateCredential(credential);
      expect(result, Right(credential));
    });

    test('should return a valid email', () async {
      final credential = Credential('douglas@gmail.com', '123456');
      final result = validator.validateCredential(credential);
      expect(result, Right(credential));
    });

    test('should return a message email is not valid', () async {
      final credential = Credential('douglas.com', '123556');
      final messageError = 'Email is not valid';
      final result = validator.validateCredential(credential);
      expect(result, Left(InvalidEmail(message: messageError)));
    });

    test('should return a message password is too short', () async {
      final credential = Credential('douglas.com', '123');
      final messageError = 'Password is too short';
      final result = validator.validateCredential(credential);
      expect(result, Left(InvalidEmail(message: messageError)));
    });
  });
}
