import 'package:app/core/error/Failure.dart';
import 'package:app/features/auth/domain/entities/user_auth.dart';
import 'package:dartz/dartz.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, UserAuth>> createAccountRequest(
      String email, String password);

  Future<Either<Failure, UserAuth>> signInRequest(
      String email, String password);

  Future<Either<Failure, bool>> signOutRequest();

  Future<Either<Failure, UserAuth>> signInWithGoogleRequest();

  Future<Either<Failure, UserAuth>> currentUserRequest();

	Either<Failure, Stream<UserAuth>> onAuthStateChanged();
}
