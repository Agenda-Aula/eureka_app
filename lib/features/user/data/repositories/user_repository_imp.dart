import 'package:app/core/error/Failure.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/user/data/datasource/user_data_source.dart';
import 'package:app/features/user/data/models/user_model.dart';
import 'package:app/features/user/data/models/user_model_to_user_mapper.dart';
import 'package:app/features/user/domain/entitties/user.dart';
import 'package:app/features/user/domain/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImp extends UserRepository {
  final UserDataSource userDataSource;
  final mapper = UserModelToUserMapper();

  UserRepositoryImp({this.userDataSource});

  @override
  Future<Either<Failure, User>> createAccount(
      String email, String password) async {
    try {
      final userModel = await userDataSource.createAccount(email, password);
      return Right(mapper.map(userModel));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> isLoggedIn() async {
    try {
      final result = await userDataSource.isSignIn();
      if (result != null) return Right(mapper.map(result));
    } on ServerException {
      return Left(ServerFailure());
    }
    return Right(null);
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    userDataSource.signOut();
    final result = await userDataSource.isSignIn();
    if (result != null)
      return Right(true);
    else
      return Right(false);
  }
}
