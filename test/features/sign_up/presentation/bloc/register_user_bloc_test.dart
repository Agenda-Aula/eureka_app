import 'package:app/features/sign_up/domain/usercases/register_user.dart';
import 'package:app/features/sign_up/presentation/bloc/sign_up_user_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUser extends Mock implements RegisterUser {}

void main() {
  SignUpUserBloc bloc;
  MockRegisterUser mockRegisterUser;

  setUp(() {
    mockRegisterUser = MockRegisterUser();

    bloc = SignUpUserBloc(registerUser: mockRegisterUser);
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });

  test('Should register user', () async {
    // assert
    final email = 'douglas@gmail.com';
    final password = 'pass!word';
    //whenListen(bloc, stream)
  });
}
