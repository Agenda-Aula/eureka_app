import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/data/models/auth_model.dart';
import 'package:app/features/authentication/domain/usecases/is_authenticated_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_authentication_repository.dart';

void main() {
  IsAuthenticatedUser isAuthUser;
  MockAuthenticationRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthenticationRepository();
    isAuthUser = IsAuthenticatedUser(repository: mockAuthRepository);
  });

  group('Group', () {
    test('should return true when user  is logged', () async {
      // arrange
      final userModel =
          AuthModel(email: "email", profileUrl: "url", displayName: "name");
      when(mockAuthRepository.getAuthenticatedUser())
          .thenAnswer((_) async => Right(userModel));
      // act
      final result = await isAuthUser.call(NoParams());
      // assert
      expect(result, Right(true));
      verify(mockAuthRepository.getAuthenticatedUser());
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return false when user  try to logged in', () async {
      // arrange
      when(mockAuthRepository.getAuthenticatedUser())
          .thenAnswer((_) async => Right(null));
      // act
      final result = await isAuthUser.call(NoParams());
      // assert
      expect(result, Right(false));
      verify(mockAuthRepository.getAuthenticatedUser());
      verifyNoMoreInteractions(mockAuthRepository);
    });

    test('should return a failure when check if user is logged in', () async {
      // arrange
      when(mockAuthRepository.getAuthenticatedUser())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await isAuthUser.call(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockAuthRepository.getAuthenticatedUser());
      verifyNoMoreInteractions(mockAuthRepository);
    });
  });
}
