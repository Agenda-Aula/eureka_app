import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/entities/auth.dart';
import 'package:app/features/authentication/domain/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class GetAuthentication implements UseCase<Auth, NoParams> {
  final AuthenticationRepository repository;

  GetAuthentication({@required this.repository});

  @override
  Future<Either<Failure, Auth>> call(NoParams params) async =>
      await repository.getAuthenticatedUser();
}
