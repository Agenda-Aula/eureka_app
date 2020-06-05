import 'package:app/authentication/domain/usecases/is_logged_in.dart';
import 'package:app/authentication/domain/usecases/logged_out.dart';
import 'package:app/authentication/presentation/authentication_bloc.dart';
import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/register/domain/entitties/user.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserLoggedOut extends Mock implements UserLoggedOut {}

class MockIsUserLoggedIn extends Mock implements IsUserLoggedIn {}


void main() {
  AuthenticationBloc bloc;
  UserLoggedOut mockUserLoggedOut;
  IsUserLoggedIn mockUserLoggedIn;

  setUp(() {
    mockUserLoggedOut = MockUserLoggedOut();
    mockUserLoggedIn = MockIsUserLoggedIn();

    bloc = AuthenticationBloc(
        isUserLoggedIn: mockUserLoggedIn,
        userLoggedOut: mockUserLoggedOut);
  });

  test('initialState should be Unitialized', () {
    // assert
    expect(bloc.initialState, equals(Uninitialized()));
  });

  blocTest('AuthenticateBloc emits Authenticated after calling get user',
      build: () {
        when(mockUserLoggedIn.call(NoParams())).thenAnswer(
          (_) async => Future.value(Right(User('', '', ''))),
        );
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: [Authenticated(user: User('', '', ''))],
      verify: (_) async {
        verify(mockUserLoggedIn.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Authenticated after calling logged in',
      build: () {
        when(mockUserLoggedIn.call(NoParams()))
            .thenAnswer((_) async => Right(User('', '', '')));
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(LoggedIn()),
      expect: [Authenticated(user: User('', '', ''))],
      verify: (_) async {
        verify(mockUserLoggedIn.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Authenticated after calling logged out',
      build: () async => bloc,
      act: (bloc) => bloc.add(LoggedOut()),
      expect: [Unauthenticated()],
      verify: (_) async {
        verify(mockUserLoggedOut.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Unauthenticated after calling AppStarted',
      build: () {
        when(mockUserLoggedIn.call(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: [Unauthenticated()],
      verify: (_) async {
        verify(mockUserLoggedIn.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Unauthenticated after calling logged in',
      build: () {
        when(mockUserLoggedIn.call(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(LoggedIn()),
      expect: [Unauthenticated()],
      verify: (_) async {
        verify(mockUserLoggedIn.call(NoParams())).called(1);
      });
}
