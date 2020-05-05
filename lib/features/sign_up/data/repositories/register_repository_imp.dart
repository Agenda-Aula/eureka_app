import 'package:app/core/error/Failure.dart';
import 'package:app/features/sign_up/data/datasource/firebase_source.dart';
import 'package:app/features/sign_up/data/models/user_model_to_user_mapper.dart';
import 'package:app/features/sign_up/domain/entities/register_user.dart';
import 'package:app/features/sign_up/domain/repositories/register_user_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUserRepositoryImp extends RegisterUserRepository {
  final AuthDataSource authDataSource;
  final mapper = UserModelToUserMapper();

  RegisterUserRepositoryImp({this.authDataSource});

  @override
  Future<Either<Failure, User>> createAccountRequest(
      String email, String password) async {
    final userModel = await authDataSource.createAccount(email, password);
    if (userModel != null) {
      return Right(mapper.map(userModel));
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
    final userModel = await authDataSource.signIn(email, password);
    if (userModel != null) {
      return Right(mapper.map(userModel));
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, User>> signInWithGoogleRequest() async {
    final userModel = await authDataSource.signInWithGoogle();
    if (userModel != null) {
      return Right(mapper.map(userModel));
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
  //TODO return a stream user from mapper.
  Either<Failure, Stream<User>> onAuthStateChanged() {
    final userModel = authDataSource.onAuthStateChanged;
    if (userModel != null) {
      return Right(userModel);
    }
    return Left(ServerFailure());
  }
}
