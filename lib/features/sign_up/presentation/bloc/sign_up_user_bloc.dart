import 'dart:async';

import 'package:app/features/sign_up/domain/usercases/register_user.dart';
import 'package:app/features/sign_up/presentation/sign_up_validator.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'sign_up_user_event.dart';

part 'sign_up_user_state.dart';

class SignUpUserBloc extends Bloc<SignUpUserEvent, SignUpUserState> {
  final RegisterUser registerUser;
  final SignUpValidator validator;

  SignUpUserBloc({@required this.registerUser, @required this.validator})
      : assert(registerUser != null),
        assert(validator != null);

  @override
  SignUpUserState get initialState => Empty();

  @override
  Stream<SignUpUserState> mapEventToState(
    SignUpUserEvent event,
  ) async* {
    if (event is SignUpUser) {
      final result = await registerUser
          .call(Params(email: event.email, password: event.password));
    }
  }
}
