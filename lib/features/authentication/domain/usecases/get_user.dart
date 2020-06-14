import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/entities/user.dart';
import 'package:app/features/authentication/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class GetUser implements UseCase<User, NoParams> {
  final UserRepository repository;

  GetUser({@required this.repository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async =>
      await repository.getAuthenticatedUser();
}