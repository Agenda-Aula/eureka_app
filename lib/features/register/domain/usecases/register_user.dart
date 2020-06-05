import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/register/domain/entitties/user.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../user_repository.dart';

class RegisterUser implements UseCase<User, Params> {
  final UserRepository repository;

  RegisterUser({@required this.repository});

  @override
  Future<Either<Failure, User>> call(Params params) async =>
      await repository.signUp(params.email, params.password);
}

class Params extends Equatable {
  final String email;
  final String password;

  Params(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
