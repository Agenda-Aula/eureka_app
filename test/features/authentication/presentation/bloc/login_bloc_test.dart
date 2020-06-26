
import 'package:app/features/authentication/domain/usecases/authenticate_with_credentials.dart';
import 'package:app/features/authentication/presentation/bloc/sign_in/sign_in.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSignInWithCredentials extends Mock implements AuthenticateWithCredentials {}

void main() {
	LoginBloc loginBloc;
	AuthenticateWithCredentials mockAuthenticateWithCredentials;

	setUp(() {
		mockAuthenticateWithCredentials = MockSignInWithCredentials();
		loginBloc = LoginBloc(signInWithCredentials: mockAuthenticateWithCredentials);

	});

	test('initialState should be Unitialized', () {
		// assert
		expect(loginBloc.initialState, equals(LoginState.empty()));
	});

	blocTest(
		'RegisterBloc emitts valid passowrd state',
		build: () async => loginBloc,
		act: (bloc) => bloc.add(PasswordChanged(password: "1234567")),
		expect: [LoginState.success()],
	);

	blocTest(
		'RegisterBloc emitts invalid  password state',
		build: () async => loginBloc,
		act: (bloc) => bloc.add(PasswordChanged(password: "12")),
		expect: [LoginState.failure()],
	);

	blocTest(
		'RegisterBloc emitts valid email state',
		build: () async => loginBloc,
		expect: [LoginState.success()],
		act: (bloc) => bloc.add(EmailChanged(email: "douglas@gmail.com")),
	);
}
