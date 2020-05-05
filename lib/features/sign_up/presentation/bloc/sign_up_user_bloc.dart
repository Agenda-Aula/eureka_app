import 'dart:async';

import 'package:app/core/error/Failure.dart';
import 'package:app/features/sign_up/domain/entities/register_user.dart';
import 'package:app/features/sign_up/domain/usercases/register_user.dart';
import 'package:app/features/sign_up/presentation/credential.dart';
import 'package:app/features/sign_up/presentation/sign_up_validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'sign_up_user_event.dart';

part 'sign_up_user_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_EMAIL = 'Invalid email';
const String INVALID_INPUT_EMPTY_EMAIL = 'Empty email';
const String INVALID_INPUT_PASSWORD = 'Invalid password';

class SignUpUserBloc extends Bloc<SignUpUserEvent, SignUpUserState> {
  final RegisterUser registerUser;
  final SignUpValidator validator = SignUpValidator();

  SignUpUserBloc({@required this.registerUser}) : assert(registerUser != null);

  @override
  SignUpUserState get initialState => Empty();

  @override
  Stream<SignUpUserState> mapEventToState(
    SignUpUserEvent event,
  ) async* {
    if (event is SignUpUser) {
      final credentialEither = validator.validateCredential(event.credential);
      yield* credentialEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_EMAIL);
        },
        (credential) async* {
          yield Loading();
          final params = Params(credential.email, credential.password);
//          final failureOrUser = await registerUser(params);
//          yield failureOrUser.fold(
//            (failure) => Error(message: SERVER_FAILURE_MESSAGE),
//            (user) => Loaded(user),
//          );
        },
      );
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
