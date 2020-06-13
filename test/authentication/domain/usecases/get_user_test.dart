import 'package:app/authentication/domain/usecases/get_user.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/sign_up/data/models/user_model.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  GetUser getUser;
  MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    getUser = GetUser(repository: mockRepository);
  });

  group('Group', () {
    test('should return user when user is logged', () async {
      // arrange
      final userModel =
          UserModel(email: "email", profileUrl: "url", displayName: "name");
      when(mockRepository.getAuthenticatedUser())
          .thenAnswer((_) async => Right(userModel));
      // act
      final result = await getUser.call(NoParams());
      // assert
      expect(result, Right(userModel));
      verify(mockRepository.getAuthenticatedUser());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should not return user when user try to logged in', () async {
      // arrange
      final userModel =
          UserModel(email: "email", profileUrl: "url", displayName: "name");
      when(mockRepository.getAuthenticatedUser())
          .thenAnswer((_) async => Right(userModel));
      // act
      final result = await getUser.call(NoParams());
      // assert
      expect(result, Right(userModel));
      verify(mockRepository.getAuthenticatedUser());
      verifyNoMoreInteractions(mockRepository);
    });
    test('should return a failure when check if user is logged in', () async {
      // arrange
      when(mockRepository.getAuthenticatedUser())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await getUser.call(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
      verify(mockRepository.getAuthenticatedUser());
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
