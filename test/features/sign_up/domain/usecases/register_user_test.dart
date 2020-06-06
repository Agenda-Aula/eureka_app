import 'package:app/core/error/Failure.dart';
import 'package:app/features/sign_up/domain/entitties/user.dart';
import 'package:app/features/sign_up/domain/usecases/sign_up_user.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUserRepository extends Mock implements UserRepository {}

void main() {
  RegisterUser usecase;
  MockRegisterUserRepository mockRepository;
  User user;
  String email = "douglas@gmail.com";
  String password = "12345678";
  String profileUrl = "http://mypic.com";
  Params params;

  setUp(() {
    mockRepository = MockRegisterUserRepository();
    usecase = RegisterUser(repository: mockRepository);
    user = User(email, password, profileUrl);
    params = Params(email, password);
  });

  group('Register user repository tests', () {

    test('should register a user from  the repoistory', () async {
      // arrange
      when(mockRepository.signUp(any, any))
          .thenAnswer((_) async => Right(user));
      // act
      final result = await usecase(params);
      // assert
      expect(result, Right(user));
      verify(mockRepository.signUp(email, password));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return an failure from the repoistory', () async {
      // arrange
      final failure = ServerFailure();
      when(mockRepository.signUp(any, any))
          .thenAnswer((_) async => Left(failure));
      // act
      final result = await usecase(Params(email, password));
      // assert
      expect(result, Left(failure));
      verify(mockRepository.signUp(email, password));
      verifyNoMoreInteractions(mockRepository);
    });

    test('verify params property', () {
      expect('${[email, password]}', params.props.toString());
    });
  });
}
