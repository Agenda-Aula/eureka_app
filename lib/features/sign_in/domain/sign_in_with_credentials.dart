import 'package:app/authentication/domain/usecases/get_user.dart';
import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class SignInWithCredentials implements UseCase<void, Params> {
  final UserRepository repository;

  SignInWithCredentials({@required this.repository});

  @override
  Future<Either<Failure, void>> call(Params params) async =>
      await repository.signInWithCredentials(params.email, params.password);
}
