import 'package:app/features/sign_up/domain/entities/user.dart';
import 'package:app/features/sign_up/domain/usercases/register_user.dart';
import 'package:app/features/sign_up/presentation/bloc/sign_up_page_bloc.dart';
import 'package:app/features/sign_up/presentation/models/credential.dart';
import 'package:app/features/sign_up/presentation/sign_up_validator.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUser extends Mock implements RegisterUser {}

class MockSignUpValidator extends Mock implements SignUpValidator {}

void main() {
  SignUpBloc bloc;
  MockRegisterUser mockRegisterUser;
  MockSignUpValidator mockValidator;

  setUp(() {
    mockRegisterUser = MockRegisterUser();
    mockValidator = MockSignUpValidator();
    bloc = SignUpBloc(registerUser: mockRegisterUser);
  });
  group('Register use', () {
    final user = User("douglas@gmail.com", "Douglas Mesquita");

    test('initialState should be Empty', () {
      // assert
      expect(bloc.initialState, equals(Empty()));
    });
    final validCredential = Credential("douglas@gmail.com","12345678");
    final invalidCredentials = Credential("douglas.com","123");

    blocTest(
      'SignUpBloc emitts [Empty] when Event is stared',
      build: () async => bloc,
      expect: [Error(message: INVALID_INPUT_EMAIL)],
      act: (bloc) => bloc.add(SignUpUser(credential: invalidCredentials)),
    );
    blocTest(
      'SignUpBloc emitts [Empty, Loading, Loaded] when data is gotten successfuly',
      build: () async => bloc,
      expect: [Empty(), Loading(), Loaded(user: user)],
      act: (bloc) => bloc.add(SignUpUser(credential: validCredential)),
    );

    blocTest(
      'SignUpBloc emitts [Empty, Loading, Error] when getting data fails',
      build: () async => bloc,
      expect: [Empty, Loading, Error(message: SERVER_FAILURE_MESSAGE)],
      act: (bloc) => bloc.add(SignUpUser(credential: validCredential)),
    );

    test('Should register user', () async {});
  });
}
