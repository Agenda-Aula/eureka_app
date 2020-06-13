import 'dart:async';
import 'package:app/authentication/domain/usecases/get_user.dart';
import 'package:app/authentication/domain/usecases/logged_out.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/sign_up/domain/entitties/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUser _getUser;
  final UserLoggedOut _userLoggedOut;

  AuthenticationBloc(
      {@required GetUser getUser,
      @required UserLoggedOut userLoggedOut})
      : assert(getUser != null),
        assert(userLoggedOut != null),
        _userLoggedOut = userLoggedOut,
        _getUser = getUser;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final result = await _getUser.call(NoParams());
    yield result.fold(
      (failure) => Unauthenticated(),
      (user) => Authenticated(user: user),
    );
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final result = await _getUser.call(NoParams());
    yield result.fold(
      (failure) => Unauthenticated(),
      (user) => Authenticated(user: user),
    );
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userLoggedOut.call(NoParams());
  }
}
