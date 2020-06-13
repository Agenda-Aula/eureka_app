import 'dart:async';

import 'package:app/core/error/failure.dart';
import 'package:app/core/error/exceptions.dart';
import 'package:app/features/sign_up/data/datasource/user_data_source.dart';
import 'package:app/features/sign_up/data/models/user_model.dart';
import 'package:app/features/sign_up/data/repositories/user_repository_imp.dart';
import 'package:app/features/sign_up/domain/entitties/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUserDataSource extends Mock implements UserDataSourceImp {}

class FutureCallbackMock extends Mock implements Function {
  Future<void> call();
}

void main() {
  MockRegisterUserDataSource mockRegisterUserDataSource;
  UserRepositoryImp repository;
  String email = "douglas@gmail.com";
  String displayName = "Douglas Mesquita";
  String profileUrl = "http://mypic.com";
  String password = "1234567";
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
      when(mockRegisterUserDataSource.signUp(any, any))
          .thenAnswer((_) async => userModel);
      // act
      final result = await repository.signUp(email, displayName);
      // assert
      verify(mockRegisterUserDataSource.signUp(email, displayName));
      verifyNoMoreInteractions(mockRegisterUserDataSource);
      expect(result, Right(user));
    });

    test('should return a failure after creating account', () async {
      // arrange
      when(mockRegisterUserDataSource.signUp(any, any))
          .thenThrow(ServerException());
      // act
      final result = await repository.signUp(email, displayName);
      // assert
      verify(mockRegisterUserDataSource.signUp(email, displayName));
      expect(result, Left(ServerFailure()));
    });

    test('should return an user if it is logged in', () async {
      // arrange
      when(mockRegisterUserDataSource.getAuthenticatedUser())
          .thenAnswer((_) async => userModel);
      // act
      final result = await repository.getAuthenticatedUser();
      // assert
      verify(mockRegisterUserDataSource.getAuthenticatedUser());
      verifyNoMoreInteractions(mockRegisterUserDataSource);
      expect(result, Right(user));
    });

    test('should return null if user is not logged in', () async {
      // arrange
      when(mockRegisterUserDataSource.getAuthenticatedUser()).thenAnswer((_) async => null);
      // act
      final result = await repository.getAuthenticatedUser();
      // assert
      verify(mockRegisterUserDataSource.getAuthenticatedUser());
      verifyNoMoreInteractions(mockRegisterUserDataSource);
      expect(result, Right(null));
    });

    test('should return a failure after creating account', () async {
      // arrange
      when(mockRegisterUserDataSource.getAuthenticatedUser()).thenThrow(ServerException());
      // act
      final result = await repository.getAuthenticatedUser();
      // assert
      verify(mockRegisterUserDataSource.getAuthenticatedUser());
      expect(result, Left(ServerFailure()));
    });

    test('should sign out user', () async {
      // arrange
      when(mockRegisterUserDataSource.getAuthenticatedUser())
          .thenAnswer((_) async => userModel);
      when(mockRegisterUserDataSource.signOut()).thenAnswer((_) async => true);
      // act
      final result = await repository.signOut();
      // assert
      verify(mockRegisterUserDataSource.getAuthenticatedUser());
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

    test('should login with credentials', () async {
      // arrange
      when(mockRegisterUserDataSource.signInWithCredentials(any, any))
          .thenAnswer((_) async => Right(true));
      // act
      final result = await repository.signInWithCredentials(email, password);
      // assert
      verify(mockRegisterUserDataSource.signInWithCredentials(email, password));
      expect(result, Right((true)));
    });

    test('should failure login with credentials', () async {
      // arrange
      when(mockRegisterUserDataSource.signInWithCredentials(email, password))
          .thenThrow(ServerException());
      // act
      final result = await repository.signInWithCredentials(email, password);
      // assert
      verify(mockRegisterUserDataSource.signInWithCredentials(email, password));
      expect(result, Left(ServerFailure()));
    });

    test('should login with google', () async {
      // arrange
      when(mockRegisterUserDataSource.signInWithGoogle())
          .thenAnswer((_) async => Right(true));
      // act
      final result = await repository.signInWithGoogle();
      // assert
      verify(mockRegisterUserDataSource.signInWithGoogle());
      expect(result, Right((true)));
    });

    test('should failure login with google', () async {
      // arrange
      when(mockRegisterUserDataSource.signInWithGoogle())
          .thenThrow(ServerException());
      // act
      final result = await repository.signInWithGoogle();
      // assert
      verify(mockRegisterUserDataSource.signInWithGoogle());
      expect(result, Left(ServerFailure()));
    });
  });
}
