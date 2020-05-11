import 'package:app/features/register/domain/usercases/register_user.dart';
import 'package:app/features/register/presentation/bloc/bloc.dart';
import 'package:app/features/register/presentation/bloc/register_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUser extends Mock implements RegisterUser {}

class MockRegisterBloc extends MockBloc<RegisterEvent, int>
    implements RegisterBloc {}

void main() {
  RegisterBloc bloc;
  MockRegisterUser mockRegisterUser;
  RegisterState passwordInvalidState;
  RegisterState emailInvalidState;

  setUp(() {
    mockRegisterUser = MockRegisterUser();
    bloc = RegisterBloc(registerUser: mockRegisterUser);
  });
  group('Register user bloc', () {
    passwordInvalidState = RegisterState(
        isEmailValid: true,
        isPasswordValid: false,
        isSubmitting: false,
        isFailure: false,
        isSuccess: false);
    emailInvalidState = RegisterState(
        isEmailValid: false,
        isPasswordValid: true,
        isSubmitting: false,
        isFailure: false,
        isSuccess: false);

    test('initialState should be Empty', () {
      // assert
      expect(bloc.initialState, equals(RegisterState.empty()));
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
      expect: [passwordInvalidState],
      act: (bloc) => bloc.add(PasswordChanged(password: "12345")),
    );

    blocTest(
      'RegisterBloc emitts valid email state',
      build: () async => bloc,
      expect: [],
      act: (bloc) => bloc.add(EmailChanged(email: "douglas@gmail.com")),
    );

    blocTest(
      'RegisterBloc emitts invalid email state',
      build: () async => bloc,
      expect: [emailInvalidState],
      act: (bloc) => bloc.add(EmailChanged(email: "douglas....")),
    );
  });
}
