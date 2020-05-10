import 'package:app/core/error/Failure.dart';
import 'package:app/features/sign_up/domain/entities/user.dart';

import 'package:dartz/dartz.dart';

abstract class RegisterUserRepository {
  Future<Either<Failure, User>> createAccount(
      String email, String password);
}
