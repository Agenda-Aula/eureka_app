import 'package:app/core/mapper/mapper.dart';
import 'package:app/user/data/models/user_model.dart';
import 'package:app/user/domain/entitties/user.dart';

class UserModelToUserMapper implements Mapper<UserModel, User> {
  @override
  User map(UserModel from) =>
      User(from.email, from.displayName, from.profileUrl);
}
