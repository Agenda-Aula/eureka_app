import 'package:app/features/sign_up/presentation/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterValidator', () {
    test('should return a valid password', () async {
      final password = "12345678";
      final result = Validators.isValidPassword(password);
      expect(result, true);
    });

    test('should return a valid email', () async {
      final email = "douglas@gmail.com";
      final result = Validators.isValidEmail(email);
      expect(result, true);
    });

    test('should return false when email is not valid', () async {
      final email = "douglas.com";
      final result = Validators.isValidEmail(email);
      expect(result, false);
    });

    test('should return false when password is too short', () async {
      final password = "123";
      final result = Validators.isValidPassword(password);
      expect(result, false);
    });
  });
}
