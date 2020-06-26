import 'package:app/core/error/failure.dart';
import 'package:app/features/authentication/domain/entities/auth.dart';


import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Auth>> registerWithCredentials(String email, String password);

  Future<Either<Failure, Auth>> getAuthenticatedUser();

  Future<Either<Failure, void>> unauthorizeSession();

	Future<Either<Failure, bool>> authenticateWithGoogle();

	Future<Either<Failure, bool>> authenticateWithCredentials(String email, String password);
}
