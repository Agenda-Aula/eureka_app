import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/authentication/domain/usecases/is_logged_in.dart';
import 'package:app/features/authentication/domain/usecases/logged_out.dart';
import 'package:app/features/authentication/presentation/authentication_bloc.dart';
import 'package:app/features/user/domain/entitties/user.dart';
import 'package:app/features/user/domain/usecases/get_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserLoggedOut extends Mock implements UserLoggedOut {}

class MockIsUserLoggedIn extends Mock implements IsUserLoggedIn {}

class MockGetUser extends Mock implements GetUser {}

void main() {
  AuthenticationBloc bloc;
  UserLoggedOut mockUserLoggedOut;
  IsUserLoggedIn mockUserLoggedIn;
  GetUser mockGetUser;

  setUp(() {
    mockUserLoggedOut = MockUserLoggedOut();
    mockUserLoggedIn = MockIsUserLoggedIn();
    mockGetUser = MockGetUser();

    bloc = AuthenticationBloc(
        isUserLoggedIn: mockUserLoggedIn,
        getUser: mockGetUser,
        userLoggedOut: mockUserLoggedOut);
  });

  test('initialState should be Unitialized', () {
    // assert
    expect(bloc.initialState, equals(Uninitialized()));
  });

  test(
    'AuthenticateBloc emitts authenticated',
    () async {
      // arrange
      final user = User('', '', '');
      when(mockGetUser(any)).thenAnswer((_) async => Right(user));
      // act
      bloc.add(LoggedIn());
      await untilCalled(mockGetUser.call(NoParams()));
      // assert
      verify(mockGetUser.call(NoParams()));
    },
  );

  test(
    'AuthenticateBloc emitts authenticated',
    () async {
      // arrange
      final user = User('', '', '');
      when(mockGetUser(any)).thenAnswer((_) async => Right(user));
      // act
      bloc.add(LoggedOut());
      await untilCalled(mockUserLoggedOut.call(NoParams()));
      // assert
      verify(mockUserLoggedOut.call(NoParams()));
    },
  );
}
