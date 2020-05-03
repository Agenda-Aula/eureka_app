import 'package:app/core/error/Failure.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/auth/data/datasource/auth_data_source.dart';
import 'package:app/features/auth/domain/entities/user_auth.dart';
import 'package:app/features/auth/domain/repositories/user_auth_repository.dart';
import 'package:dartz/dartz.dart';

class UserAuthRepositoryImp extends UserAuthRepository {
  final AuthDataSource authDataSource;

  UserAuthRepositoryImp({this.authDataSource});

  @override
  Future<Either<Failure, UserAuth>> createAccountRequest(
      String email, String password) async {
    final userAuth = await authDataSource.createAccount(email, password);
    if (userAuth != null) {
      return Right(userAuth);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserAuth>> currentUserRequest() async {
    final userAuth = await authDataSource.currentUser();
    if (userAuth != null) {
      return Right(userAuth);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserAuth>> signInRequest(
      String email, String password) async {
    final userAuth = await authDataSource.signIn(email, password);
    if (userAuth != null) {
      return Right(userAuth);
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, UserAuth>> signInWithGoogleRequest() async {
    final userAuth = await authDataSource.signInWithGoogle();
    if (userAuth != null) {
      return Right(userAuth);
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, bool>> signOutRequest() async {
    final isSignedOut = await authDataSource.signOut();
    if (isSignedOut) {
      return Right(true);
    }
    return Left(ServerFailure());
  }

  @override
  Either<Failure, Stream<UserAuth>> onAuthStateChanged() {
    final userAuth = authDataSource.onAuthStateChanged;
    if (userAuth != null) {
      return Right(userAuth);
    }
    return Left(ServerFailure());
  }
}
