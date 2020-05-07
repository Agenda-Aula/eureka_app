import 'package:app/core/error/Failure.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/sign_up/data/datasource/auth_data_source.dart';
import 'package:app/features/sign_up/data/models/user_model.dart';
import 'package:app/features/sign_up/data/repositories/register_user_repository_imp.dart';
import 'package:app/features/sign_up/domain/entities/register_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

void main() {
  MockAuthDataSource mockAuthDataSource;
  RegisterUserRepositoryImp repository;
  String email = "douglas@gmail.com";
  String displayName = "Douglas Mesquita";

  setUp(() {
    mockAuthDataSource = MockAuthDataSource();
    repository = RegisterUserRepositoryImp(authDataSource: mockAuthDataSource);
  });

  group('Auth data source tests', () {
    test('should create a user', () async {
      // arrange
      final userModel = UserModel(email: email, displayName: displayName);
      final user = User(email, displayName);
      when(mockAuthDataSource.createAccount(any, any))
          .thenAnswer((_) async => userModel);
      // act
      final result = await repository.createAccountRequest(email, displayName);
      // assert
      verify(mockAuthDataSource.createAccount(email, displayName));
      expect(result, equals(Right(user)));
    });

    test('should return  a failure', () async {
      // arrange
      final userModel = UserModel(email: email, displayName: displayName);
      final user = User(email, displayName);
      when(mockAuthDataSource.createAccount(any, any))
          .thenThrow(ServerException());
      // act
      final result = await repository.createAccountRequest(email, displayName);
      // assert
      verify(mockAuthDataSource.createAccount(email, displayName));
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
