import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/user/domain/entitties/user.dart';
import 'package:app/features/user/domain/usecases/get_user.dart';
import 'package:app/features/user/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUserRepository extends Mock implements UserRepository {}

void main() {
  GetUser getUser;
  MockRegisterUserRepository mockRepository;
  User user;
  String email = "douglas@gmail.com";
  String password = "12345678";
  String profileUrl = "http://mypic.com";

  setUp(() {
    mockRepository = MockRegisterUserRepository();
    getUser = GetUser(repository: mockRepository);
    user = User(email, password, profileUrl);
  });

  group('Get user repository tests', () {
    test('should return an user from  the repoistory', () async {
      // arrange
      when(mockRepository.isLoggedIn()).thenAnswer((_) async => Right(user));
      // act
      final result = await getUser.call(NoParams());
      // assert
      expect(result, Right(user));
      verify(mockRepository.isLoggedIn());
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return an failure from the repoistory', () async {
      // arrange
      final failure = ServerFailure();
      when(mockRepository.isLoggedIn()).thenAnswer((_) async => Left(failure));
      // act
      final result = await getUser.call(NoParams());
      // assert
      expect(result, Left(failure));
      verify(mockRepository.isLoggedIn());
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
