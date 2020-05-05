import 'package:app/core/mapper/mapper.dart';
import 'package:app/features/sign_up/data/models/user_model.dart';
import 'package:app/features/sign_up/domain/entities/register_user.dart';

class UserModelToUserMapper implements Mapper<UserModel, User> {
  @override
  User map(UserModel from) => User(from.email, from.displayName);
}
