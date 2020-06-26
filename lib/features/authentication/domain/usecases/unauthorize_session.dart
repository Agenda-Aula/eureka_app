import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class UnauthorizeSession implements UseCase<void, NoParams> {
  final AuthenticationRepository repository;

  UnauthorizeSession({@required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async =>
      await repository.unauthorizeSession();
}
