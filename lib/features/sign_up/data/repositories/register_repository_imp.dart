import 'package:app/core/error/Failure.dart';
import 'package:app/features/sign_up/data/datasource/firebase_source.dart';
import 'package:app/features/sign_up/domain/entities/register_user.dart';
import 'package:app/features/sign_up/domain/repositories/register_user_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUserRepositoryImp extends RegisterUserRepository {
  final AuthDataSource authDataSource;

  RegisterUserRepositoryImp({this.authDataSource});

  @override
  Future<Either<Failure, User>> createAccountRequest(
      String email, String password) async {
    final user = await authDataSource.createAccount(email, password);
    if (user != null) {
      return Right(user);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> currentUserRequest() async {
    final userAuth = await authDataSource.currentUser();
    if (userAuth != null) {
      return Right(userAuth);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signInRequest(
      String email, String password) async {
    final userAuth = await authDataSource.signIn(email, password);
    if (userAuth != null) {
      return Right(userAuth);
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, User>> signInWithGoogleRequest() async {
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
  Either<Failure, Stream<User>> onAuthStateChanged() {
    final userAuth = authDataSource.onAuthStateChanged;
    if (userAuth != null) {
      return Right(userAuth);
    }
    return Left(ServerFailure());
  }
}
