import 'package:app/authentication/domain/usecases/is_authenticated_user.dart';
import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  IsAuthenticatedUser isAuthUser;
  MockUserRepository mockRepository;
	Params params;

  setUp(() {
    mockRepository = MockUserRepository();
    isAuthUser = IsAuthenticatedUser(repository: mockRepository);
  });

  group('Group', () {
    test('should return true when user  is logged', () async {
      // arrange
      when(mockRepository.isAuthenticatedUser())
          .thenAnswer((_) async => Right(true));
      // act
      final result = await isAuthUser.call(NoParams());
      // assert
      expect(result, Right(true));
      verify(mockRepository.isAuthenticatedUser());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return false when user  try to logged in', () async {
      // arrange
      when(mockRepository.isAuthenticatedUser())
          .thenAnswer((_) async => Right(false));
      // act
      final result = await isAuthUser.call(NoParams());
      // assert
      expect(result, Right(false));
      verify(mockRepository.isAuthenticatedUser());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a failure when check if user is logged in', () async {
      // arrange
      when(mockRepository.isAuthenticatedUser())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await isAuthUser.call(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockRepository.isAuthenticatedUser());
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
