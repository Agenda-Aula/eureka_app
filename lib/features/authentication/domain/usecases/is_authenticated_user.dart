import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class IsAuthenticatedUser implements UseCase<bool, NoParams> {
  final UserRepository repository;

  IsAuthenticatedUser({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final user =  await repository.getAuthenticatedUser();
    return user.fold(
          (failure) => Left(ServerFailure()),
          (user) => Right(user != null),
    );
  }
}