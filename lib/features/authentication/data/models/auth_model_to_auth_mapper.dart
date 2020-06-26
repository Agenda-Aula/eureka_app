import 'package:app/core/mapper/mapper.dart';
import 'package:app/features/authentication/data/models/auth_model.dart';
import 'package:app/features/authentication/domain/entities/auth.dart';

class AuthModelToUserMapper implements Mapper<AuthModel, Auth> {
  @override
  Auth map(AuthModel from) =>
      Auth(from.email, from.displayName, from.profileUrl);
}
