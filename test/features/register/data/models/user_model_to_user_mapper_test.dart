import 'package:app/features/sign_up/data/models/user_model.dart';
import 'package:app/features/sign_up/data/models/user_model_to_user_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final mapper = UserModelToUserMapper();
  test('should map from a user model to use', () async {
    // arrange
    final userModel =
        UserModel(email: "douglas@gmail.com", displayName: "password");
    // act
    final expected = mapper.map(userModel);
    // assert
    expect(expected.email, userModel.email);
    expect(expected.displayName, userModel.displayName);
  });
}
