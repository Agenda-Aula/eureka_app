import 'package:app/core/error/Failure.dart';
import 'package:app/features/register/domain/entities/user.dart';
import 'package:app/features/register/domain/register_user_repository.dart';
import 'package:app/features/register/domain/usercases/register_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUserRepository extends Mock
    implements RegisterUserRepository {}

void main() {
  RegisterUser usecase;
  MockRegisterUserRepository mockRepository;
  User user;
  String email = "douglas@gmail.com";
  String password = "12345678";

  setUp(() {
    mockRepository = MockRegisterUserRepository();
    usecase = RegisterUser(repository: mockRepository);
    user = User(email, password);
  });

  group('Register user repository tests', () {
    test('should register a user from  the repoistory', () async {
      // arrange
      when(mockRepository.createAccount(any, any))
          .thenAnswer((_) async => Right(user));
      // act
      final result = await usecase(Params(email, password));
      // assert
      expect(result, Right(user));
      verify(mockRepository.createAccount(email, password));
      verifyNoMoreInteractions(mockRepository);
    });
    test('should return an failure from the repoistory', () async {
      // arrange
      final failure = ServerFailure();
      when(mockRepository.createAccount(any, any))
          .thenAnswer((_) async => Left(failure));
      // act
      final result = await usecase(Params(email, password));
      // assert
      expect(result, Left(failure));
      verify(mockRepository.createAccount(email, password));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
