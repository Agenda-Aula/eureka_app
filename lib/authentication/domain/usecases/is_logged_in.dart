import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/register/domain/entitties/user.dart';
import 'package:app/features/register/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class IsUserLoggedIn implements UseCase<User, NoParams> {
  final UserRepository repository;

  IsUserLoggedIn({@required this.repository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async =>
      await repository.isLoggedIn();
}

class Params extends Equatable {
  final String email;
  final String password;

  Params(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
