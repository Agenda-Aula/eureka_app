import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/sign_up/domain/entities/register_user.dart';
import 'package:app/features/sign_up/domain/repositories/register_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class RegisterUser implements UseCase<User, Params> {
  final RegisterUserRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, User>> call(Params params) async =>
      await repository.createAccountRequest(params.email, params.password);
}

class Params extends Equatable {
  final String email;
  final String password;

  Params(this.email, this.password);

  @override
  List<Object> get props => [email];
}
