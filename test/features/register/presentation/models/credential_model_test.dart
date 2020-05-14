import 'package:app/features/register/presentation/models/credential.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be a subclass of credential entity', () {
    // assert
    final credential = Credential("douglas@gmail.com", "password");
    expect(credential, isA<Credential>());
  });
}
