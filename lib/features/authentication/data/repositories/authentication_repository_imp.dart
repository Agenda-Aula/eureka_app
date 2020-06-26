import 'package:app/core/error/failure.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/authentication/data/models/auth_model_to_auth_mapper.dart';
import 'package:app/features/authentication/data/service/authentication_service.dart';
import 'package:app/features/authentication/domain/entities/auth.dart';
import 'package:app/features/authentication/domain/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImp extends AuthenticationRepository {
  final AuthenticationService authenticationService;
  final mapper = AuthModelToUserMapper();

  UserRepositoryImp({this.authenticationService});

  @override
  Future<Either<Failure, Auth>> registerWithCredentials(String email, String password) async {
    try {
      final authModel = await authenticationService.signUp(email, password);
      return Right(mapper.map(authModel));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> getAuthenticatedUser() async {
    try {
      final result = await authenticationService.getAuthenticatedUser();
      if (result != null) return Right(mapper.map(result));
    } on ServerException {
      return Left(ServerFailure());
    }
    return Right(null);
  }

  @override
  Future<Either<Failure, bool>> unauthorizeSession() async {
    authenticationService.signOut();
    final result = await authenticationService.getAuthenticatedUser();
    if (result != null)
      return Right(true);
    else
      return Right(false);
  }

  @override
  Future<Either<Failure, bool>> authenticateWithCredentials(
      String email, String password) async {
    try {
      await authenticationService.signInWithCredentials(email, password);
      return Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> authenticateWithGoogle() async {
    try {
      await authenticationService.signInWithGoogle();
      return Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
