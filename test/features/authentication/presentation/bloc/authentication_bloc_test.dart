import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/entities/auth.dart';
import 'package:app/features/authentication/domain/usecases/get_authenticate_user.dart';
import 'package:app/features/authentication/domain/usecases/unauthorize_session.dart';

import 'package:app/features/authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUnauthorizeSession extends Mock implements UnauthorizeSession {}

class MockGetAuthenticateUser extends Mock implements GetAuthentication {}

void main() {
  AuthenticationBloc bloc;
  MockUnauthorizeSession  mockUnauthorizeSession;
  GetAuthentication mockGetAuthentication;

  setUp(() {
    mockUnauthorizeSession = MockUnauthorizeSession();
    mockGetAuthentication = MockGetAuthenticateUser();

    bloc = AuthenticationBloc(
        getAuthorization: mockGetAuthentication,
        unauthorizeSession: mockUnauthorizeSession);
  });

  test('initialState should be Unitialized', () {
    // assert
    expect(bloc.initialState, equals(Uninitialized()));
  });

  blocTest('AuthenticateBloc emits Authenticated after calling get user',
      build: () {
        when(mockGetAuthentication.call(NoParams())).thenAnswer(
          (_) async => Future.value(Right(Auth('', '', ''))),
        );
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: [Authenticated(user: Auth('', '', ''))],
      verify: (_) async {
        verify(mockGetAuthentication.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Authenticated after calling logged in',
      build: () {
        when(mockGetAuthentication.call(NoParams()))
            .thenAnswer((_) async => Right(Auth('', '', '')));
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(LoggedIn()),
      expect: [Authenticated(user: Auth('', '', ''))],
      verify: (_) async {
        verify(mockGetAuthentication.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Authenticated after calling logged out',
      build: () async => bloc,
      act: (bloc) => bloc.add(LoggedOut()),
      expect: [Unauthenticated()],
      verify: (_) async {
        verify(mockUnauthorizeSession.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Unauthenticated after calling AppStarted',
      build: () {
        when(mockGetAuthentication.call(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: [Unauthenticated()],
      verify: (_) async {
        verify(mockGetAuthentication.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Unauthenticated after calling logged in',
      build: () {
        when(mockGetAuthentication.call(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(LoggedIn()),
      expect: [Unauthenticated()],
      verify: (_) async {
        verify(mockGetAuthentication.call(NoParams())).called(1);
      });
}
