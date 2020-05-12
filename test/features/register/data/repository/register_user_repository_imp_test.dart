import 'package:app/core/error/Failure.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/register/data/datasource/register_user_data_source.dart';
import 'package:app/features/register/data/models/user_model.dart';
import 'package:app/features/register/data/repositories/register_user_repository_imp.dart';
import 'package:app/features/register/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUserDataSource extends Mock
    implements RegisterUserDataSourceImp {}

void main() {
  MockRegisterUserDataSource mockRegisterUserDataSource;
  RegisterUserRepositoryImp repository;
  String email = "douglas@gmail.com";
  String displayName = "Douglas Mesquita";

  setUp(() {
    mockRegisterUserDataSource = MockRegisterUserDataSource();
    repository =
        RegisterUserRepositoryImp(authDataSource: mockRegisterUserDataSource);
  });

  group('Auth data source tests', () {
    test('should create an user', () async {
      // arrange
      final userModel = UserModel(email: email, displayName: displayName);
      final user = User(email, displayName);
      when(mockRegisterUserDataSource.createAccount(any, any))
          .thenAnswer((_) async => userModel);
      // act
      final result = await repository.createAccount(email, displayName);
      // assert
      verify(mockRegisterUserDataSource.createAccount(email, displayName));
      verifyNoMoreInteractions(mockRegisterUserDataSource);
      expect(result, equals(Right(user)));
    });

    test('should return  a failure', () async {
      // arrange
      final userModel = UserModel(email: email, displayName: displayName);
      final user = User(email, displayName);
      when(mockRegisterUserDataSource.createAccount(any, any))
          .thenThrow(ServerException());
      // act
      final result = await repository.createAccount(email, displayName);
      // assert
      verify(mockRegisterUserDataSource.createAccount(email, displayName));
      expect(result, equals(Left(ServerFailure())));
    });
  });
}
