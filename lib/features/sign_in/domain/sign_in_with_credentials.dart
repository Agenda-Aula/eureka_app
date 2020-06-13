import 'package:app/authentication/domain/usecases/get_user.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class SignInWithCredentials implements UseCase<void, Params> {
  final UserRepository repository;

  SignInWithCredentials({@required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) async =>
      await repository.signInWithCredentials(params.email, params.password);
}

class Params extends Equatable {
  final String email;
  final String password;

  Params(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}