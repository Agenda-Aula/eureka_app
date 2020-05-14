import 'dart:async';

import 'package:app/core/error/Failure.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/user/data/datasource/user_data_source.dart';
import 'package:app/features/user/data/models/user_model.dart';
import 'package:app/features/user/data/repositories/user_repository_imp.dart';
import 'package:app/features/user/domain/entitties/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUserDataSource extends Mock
    implements RegisterUserDataSourceImp {}

class FutureCallbackMock extends Mock implements Function {
  Future<void> call();
}

void main() {
  MockRegisterUserDataSource mockRegisterUserDataSource;
  UserRepositoryImp repository;
  String email = "douglas@gmail.com";
  String displayName = "Douglas Mesquita";
  String profileUrl = "http://mypic.com";
  UserModel userModel;
  User user;

  setUp(() {
    mockRegisterUserDataSource = MockRegisterUserDataSource();
    repository = UserRepositoryImp(userDataSource: mockRegisterUserDataSource);
    userModel = UserModel(
        email: email, displayName: displayName, profileUrl: profileUrl);
    user = User(email, displayName, profileUrl);
  });

  group('User data source tests', () {
    test('should create an user', () async {
      // arrange
      when(mockRegisterUserDataSource.createAccount(any, any))
          .thenAnswer((_) async => userModel);
      // act
      final result = await repository.createAccount(email, displayName);
      // assert
      verify(mockRegisterUserDataSource.createAccount(email, displayName));
      verifyNoMoreInteractions(mockRegisterUserDataSource);
      expect(result, Right(user));
    });

    test('should return a failure after creating account', () async {
      // arrange
      when(mockRegisterUserDataSource.createAccount(any, any))
          .thenThrow(ServerException());
      // act
      final result = await repository.createAccount(email, displayName);
      // assert
      verify(mockRegisterUserDataSource.createAccount(email, displayName));
      expect(result, Left(ServerFailure()));
    });

    test('should return an user if it is logged in', () async {
      // arrange
      when(mockRegisterUserDataSource.isSignIn())
          .thenAnswer((_) async => userModel);
      // act
      final result = await repository.isLoggedIn();
      // assert
      verify(mockRegisterUserDataSource.isSignIn());
      verifyNoMoreInteractions(mockRegisterUserDataSource);
      expect(result, Right(user));
    });

    test('should return null if user is not logged in', () async {
      // arrange
      when(mockRegisterUserDataSource.isSignIn()).thenAnswer((_) async => null);
      // act
      final result = await repository.isLoggedIn();
      // assert
      verify(mockRegisterUserDataSource.isSignIn());
      verifyNoMoreInteractions(mockRegisterUserDataSource);
      expect(result, Right(null));
    });

    test('should return a failure after creating account', () async {
      // arrange
      when(mockRegisterUserDataSource.isSignIn()).thenThrow(ServerException());
      // act
      final result = await repository.isLoggedIn();
      // assert
      verify(mockRegisterUserDataSource.isSignIn());
      expect(result, Left(ServerFailure()));
    });

    test('should sign out user', () async {
      // arrange
      when(mockRegisterUserDataSource.isSignIn())
          .thenAnswer((_) async => userModel);
      when(mockRegisterUserDataSource.signOut()).thenAnswer((_) async => true);
      // act
      final result = await repository.signOut();
      // assert
      verify(mockRegisterUserDataSource.isSignIn());
      verify(mockRegisterUserDataSource.signOut());

      expect(result, Right(true));
    });

    test('should return a failure when try to sign out', () async {
      // arrange
      when(mockRegisterUserDataSource.signOut())
          .thenAnswer((_) async => Right(false));
      // act
      final result = await repository.signOut();
      // assert
      verify(mockRegisterUserDataSource.signOut());

      expect(result, Right((false)));
    });
  });
}
