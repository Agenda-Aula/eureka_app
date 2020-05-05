import 'package:app/core/error/Failure.dart';
import 'package:app/features/sign_up/domain/entities/register_user.dart';

import 'package:dartz/dartz.dart';

abstract class RegisterUserRepository {
  Future<Either<Failure, User>> createAccountRequest(
      String email, String password);

  Future<Either<Failure, User>> signInRequest(
      String email, String password);

  Future<Either<Failure, bool>> signOutRequest();

  Future<Either<Failure, User>> signInWithGoogleRequest();

  Future<Either<Failure, User>> currentUserRequest();

  Either<Failure, Stream<User>> onAuthStateChanged();
}
