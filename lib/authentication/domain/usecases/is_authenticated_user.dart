import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/sign_up/domain/entitties/user.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class IsAuthenticatedUser implements UseCase<bool, NoParams> {
  final UserRepository repository;

  IsAuthenticatedUser({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) async =>
      await repository.isAuthenticatedUser();
}

class Params extends Equatable {
  final String email;
  final String password;

  Params(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
