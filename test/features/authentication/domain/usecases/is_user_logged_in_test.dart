import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/authentication/domain/usecases/logged_in.dart';
import 'package:app/features/user/data/models/user_model.dart';
import 'package:app/features/user/domain/entitties/user.dart';
import 'package:app/features/user/domain/user_repository.dart';
import 'package:app/features/user/domain/usecases/register_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  IsUserLoggedIn usecase;
  MockUserRepository mockRepository;
  setUp(() {
    mockRepository = MockUserRepository();
    usecase = IsUserLoggedIn(repository: mockRepository);
  });

  group('Group', () {
    test('should return true when user  is logged', () async {
      // arrange
      final userModel =
          UserModel(email: "email", profileUrl: "url", displayName: "name");
      when(mockRepository.isLoggedIn())
          .thenAnswer((_) async => Right(userModel));
      // act
      final result = await usecase.call(NoParams());
      // assert
      expect(result, Right(userModel));
      verify(mockRepository.isLoggedIn());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return false when user  try to logged in', () async {
      // arrange
      final userModel =
          UserModel(email: "email", profileUrl: "url", displayName: "name");
      when(mockRepository.isLoggedIn())
          .thenAnswer((_) async => Right(userModel));
      // act
      final result = await usecase.call(NoParams());
      // assert
      expect(result, Right(userModel));
      verify(mockRepository.isLoggedIn());
      verifyNoMoreInteractions(mockRepository);
    });
    test('should return a failure when check if user is logged in', () async {
      // arrange
      when(mockRepository.isLoggedIn())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await usecase.call(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockRepository.isLoggedIn());
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
