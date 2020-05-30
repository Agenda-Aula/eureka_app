import 'package:app/features/login/domain/sign_in_with_credentials.dart';
import 'package:app/features/login/presentation/bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockSignInWithCredentials extends Mock implements SignInWithCredentials {}

void main() {
	LoginBloc loginBloc;
	SignInWithCredentials mockSignInWithCredentials;

	setUp(() {
		mockSignInWithCredentials = MockSignInWithCredentials();
		loginBloc = LoginBloc(signInWithCredentials: mockSignInWithCredentials);

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
