import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/data/models/user_model.dart';
import 'package:app/features/authentication/domain/usecases/is_authenticated_user.dart';
import 'package:app/features/authentication/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  IsAuthenticatedUser isAuthUser;
  MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    isAuthUser = IsAuthenticatedUser(repository: mockRepository);
  });

  group('Group', () {
    test('should return true when user  is logged', () async {
      // arrange
      final userModel =
      UserModel(email: "email", profileUrl: "url", displayName: "name");
      when(mockRepository.getAuthenticatedUser())
          .thenAnswer((_) async => Right(userModel));
      // act
      final result = await isAuthUser.call(NoParams());
      // assert
      expect(result, Right(true));
      verify(mockRepository.getAuthenticatedUser());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return false when user  try to logged in', () async {
      // arrange
      when(mockRepository.getAuthenticatedUser())
          .thenAnswer((_) async => Right(null));
      // act
      final result = await isAuthUser.call(NoParams());
      // assert
      expect(result, Right(false));
      verify(mockRepository.getAuthenticatedUser());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return a failure when check if user is logged in', () async {
      // arrange
      when(mockRepository.getAuthenticatedUser())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await isAuthUser.call(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockRepository.getAuthenticatedUser());
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
