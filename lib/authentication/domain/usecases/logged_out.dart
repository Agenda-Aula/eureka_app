import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class UserLoggedOut implements UseCase<void, NoParams> {
  final UserRepository repository;

  UserLoggedOut({@required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async =>
      await repository.signOut();
}
