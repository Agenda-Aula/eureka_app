import 'dart:async';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/entities/auth.dart';
import 'package:app/features/authentication/domain/usecases/get_authenticate_user.dart';
import 'package:app/features/authentication/domain/usecases/unauthorize_session.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetAuthentication _getUser;
  final UnauthorizeSession _unauthorizeSession;

  AuthenticationBloc(
      {@required GetAuthentication getAuthorization,
      @required UnauthorizeSession unauthorizeSession})
      : assert(getAuthorization != null),
        assert(unauthorizeSession != null),
        _unauthorizeSession = unauthorizeSession,
        _getUser = getAuthorization;

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
      (auth) => Authenticated(user: auth),
    );
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    final result = await _getUser.call(NoParams());
    yield result.fold(
      (failure) => Unauthenticated(),
      (auth) => Authenticated(user: auth),
    );
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _unauthorizeSession.call(NoParams());
  }
}
