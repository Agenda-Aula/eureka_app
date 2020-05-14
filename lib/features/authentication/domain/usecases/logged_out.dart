import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/user/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class UserLoggedOut implements UseCase<void, NoParams> {
  final UserRepository repository;

  UserLoggedOut({@required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async =>
      await repository.signOut();
}
