import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/auth/domain/entities/user_auth.dart';
import 'package:app/features/auth/domain/repositories/user_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class CreateAccount implements UseCase<UserAuth, Params> {
  final UserAuthRepository authRepository;

  CreateAccount({this.authRepository});

  @override
  Future<Either<Failure, UserAuth>> call(Params params) async {
    return await authRepository.createAccountRequest(
        params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({this.email, this.password});

  @override
  List<Object> get props => [email];
}
