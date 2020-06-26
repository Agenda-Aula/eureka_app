import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/entities/auth.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../authentication_repository.dart';

class RegisterWithCredentials implements UseCase<Auth, Params> {
  final AuthenticationRepository repository;

  RegisterWithCredentials({@required this.repository});

  @override
  Future<Either<Failure, Auth>> call(Params params) async =>
      await repository.registerWithCredentials(params.email, params.password);
}

class Params extends Equatable {
  final String email;
  final String password;

  Params(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
