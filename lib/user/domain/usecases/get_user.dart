import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/user/domain/entitties/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../user_repository.dart';

class GetUser implements UseCase<User, NoParams> {
  final UserRepository repository;

  GetUser({@required this.repository});

  @override
  Future<Either<Failure, User>> call(NoParams params) => repository.isLoggedIn();
}
