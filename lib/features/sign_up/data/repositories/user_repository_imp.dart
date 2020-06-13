import 'package:app/core/error/Failure.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/sign_up/data/datasource/user_data_source.dart';
import 'package:app/features/sign_up/data/models/user_model_to_user_mapper.dart';
import 'package:app/features/sign_up/domain/entitties/user.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImp extends UserRepository {
  final UserDataSource userDataSource;
  final mapper = UserModelToUserMapper();

  UserRepositoryImp({this.userDataSource});

  @override
  Future<Either<Failure, User>> signUp(String email, String password) async {
    try {
      final userModel = await userDataSource.signUp(email, password);
      return Right(mapper.map(userModel));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getAuthenticatedUser() async {
    try {
      final result = await userDataSource.getAuthenticatedUser();
      if (result != null) return Right(mapper.map(result));
    } on ServerException {
      return Left(ServerFailure());
    }
    return Right(null);
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    userDataSource.signOut();
    final result = await userDataSource.getAuthenticatedUser();
    if (result != null)
      return Right(true);
    else
      return Right(false);
  }

  @override
  Future<Either<Failure, bool>> signInWithCredentials(
      String email, String password) async {
    try {
      await userDataSource.signInWithCredentials(email, password);
      return Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signInWithGoogle() async {
    try {
      await userDataSource.signInWithGoogle();
      return Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
