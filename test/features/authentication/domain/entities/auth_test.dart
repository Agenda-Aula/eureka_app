import 'package:app/features/authentication/data/models/auth_model.dart';
import 'package:app/features/authentication/domain/entities/auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should be a subclass of user entity', () async {
    // assert
    final userModel =
        AuthModel(email: "douglas@gmail.com", displayName: "password", profileUrl: "profileUrl");
    expect(userModel, isA<Auth>());
  });
  test('should map UserModel to User ', () async {
    // arrange
    final userModel =
        AuthModel(email: "douglas@gmail.com", displayName: "douglas alipio", profileUrl: "profileUrl");
    final user = Auth('douglas@gmail.com', 'douglas alipio', 'http://mypicture.com');
    // act
    final expected = userModel.mapper;
    // assert
    expect(expected, user);
  });
}
