import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/entities/user.dart';
import 'package:app/features/authentication/domain/usecases/get_user.dart';
import 'package:app/features/authentication/domain/usecases/logged_out.dart';
import 'package:app/features/authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserLoggedOut extends Mock implements UserLoggedOut {}

class MockGetUser extends Mock implements GetUser {}


void main() {
  AuthenticationBloc bloc;
  UserLoggedOut mockUserLoggedOut;
  GetUser mockGetUser;

  setUp(() {
    mockUserLoggedOut = MockUserLoggedOut();
    mockGetUser = MockGetUser();

    bloc = AuthenticationBloc(
        getUser: mockGetUser,
        userLoggedOut: mockUserLoggedOut);
  });

  test('initialState should be Unitialized', () {
    // assert
    expect(bloc.initialState, equals(Uninitialized()));
  });

  blocTest('AuthenticateBloc emits Authenticated after calling get user',
      build: () {
        when(mockGetUser.call(NoParams())).thenAnswer(
          (_) async => Future.value(Right(User('', '', ''))),
        );
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: [Authenticated(user: User('', '', ''))],
      verify: (_) async {
        verify(mockGetUser.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Authenticated after calling logged in',
      build: () {
        when(mockGetUser.call(NoParams()))
            .thenAnswer((_) async => Right(User('', '', '')));
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(LoggedIn()),
      expect: [Authenticated(user: User('', '', ''))],
      verify: (_) async {
        verify(mockGetUser.call(NoParams())).called(1);
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
        when(mockGetUser.call(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(AppStarted()),
      expect: [Unauthenticated()],
      verify: (_) async {
        verify(mockGetUser.call(NoParams())).called(1);
      });

  blocTest('AuthenticateBloc emits Unauthenticated after calling logged in',
      build: () {
        when(mockGetUser.call(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return Future.value(bloc);
      },
      act: (bloc) => bloc.add(LoggedIn()),
      expect: [Unauthenticated()],
      verify: (_) async {
        verify(mockGetUser.call(NoParams())).called(1);
      });
}
