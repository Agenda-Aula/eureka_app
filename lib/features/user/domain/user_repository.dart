import 'package:app/core/error/Failure.dart';
import 'package:app/features/user/domain/entitties/user.dart';

import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> createAccount(String email, String password);

  Future<Either<Failure, User>> isLoggedIn();

  Future<Either<Failure, void>> signOut();
}
