import 'package:app/core/error/Failure.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/register/data/datasource/register_user_data_source.dart';
import 'package:app/features/register/data/models/user_model_to_user_mapper.dart';
import 'package:app/features/register/domain/entities/user.dart';
import 'package:app/features/register/domain/register_user_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUserRepositoryImp extends RegisterUserRepository {
  final RegisterUserDataSource authDataSource;
  final mapper = UserModelToUserMapper();

  RegisterUserRepositoryImp({this.authDataSource});

  @override
  Future<Either<Failure, User>> createAccount(
      String email, String password) async {
    try {
      final userModel = await authDataSource.createAccount(email, password);
      return Right(mapper.map(userModel));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
