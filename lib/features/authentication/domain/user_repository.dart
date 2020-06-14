import 'package:app/core/error/failure.dart';
import 'package:app/features/authentication/domain/entities/user.dart';


import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signUp(String email, String password);

  Future<Either<Failure, User>> getAuthenticatedUser();

  Future<Either<Failure, void>> signOut();

	Future<Either<Failure, bool>> signInWithGoogle();

	Future<Either<Failure, bool>> signInWithCredentials(String email, String password);
}
