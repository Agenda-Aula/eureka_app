import 'package:app/features/login/domain/sign_in_with_credentials.dart';
import 'package:app/features/login/presentation/bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSignInWithCredentials extends Mock implements SignInWithCredentials {}

void main() {
  LoginBloc bloc;
  SignInWithCredentials mockSignInWithCredentials;

  setUp(() {
    mockSignInWithCredentials = MockSignInWithCredentials();
    bloc = LoginBloc(signInWithCredentials: mockSignInWithCredentials);
  });

  test('initialState should be Unitialized', () {
    // assert
    expect(bloc.initialState, equals(LoginState.empty()));
  });

  blocTest(
    'RegisterBloc emitts valid passowrd state',
    build: () async => bloc,
    expect: [],
    act: (bloc) => bloc.add(PasswordChanged(password: "1234567")),
  );

  blocTest(
    'RegisterBloc emitts invalid  password state',
    build: () async => bloc,
    expect: [PasswordChanged(password: "12345")],
    act: (bloc) => bloc.add(PasswordChanged(password: "12345")),
  );

  blocTest(
    'RegisterBloc emitts valid email state',
    build: () async => bloc,
    expect: [LoginState.success()],
    act: (bloc) => bloc.add(EmailChanged(email: "douglas@gmail.com")),
  );
}
