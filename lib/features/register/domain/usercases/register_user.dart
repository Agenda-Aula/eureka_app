import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/register/domain/entities/user.dart';
import 'package:app/features/register/domain/register_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class RegisterUser implements UseCase<User, Params> {
  final RegisterUserRepository repository;

  RegisterUser({@required this.repository});

  @override
  Future<Either<Failure, User>>  call(Params params) async =>
      await repository.createAccount(params.email, params.password);
}

class Params extends Equatable {
  final String email;
  final String password;

  Params(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
