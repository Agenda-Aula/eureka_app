import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class AuthenticateWithCredentials implements UseCase<void, Params> {
  final AuthenticationRepository repository;

  AuthenticateWithCredentials({@required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) async =>
      await repository.authenticateWithCredentials(params.email, params.password);
}

class Params extends Equatable {
  final String email;
  final String password;

  Params(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
