import 'package:app/authentication/domain/usecases/get_user.dart';
import 'package:app/authentication/domain/usecases/logged_out.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'get_user_test.dart';

void main() {
  UserLoggedOut userLogedOut;
  MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    userLogedOut = UserLoggedOut(repository: mockRepository);
  });

  group('Group', () {
    test('should return true when user  sign out', () async {
      // arrange
      when(mockRepository.signOut()).thenAnswer((_) async => Right(true));
      // act
      final result = await userLogedOut.call(NoParams());
      // assert
      expect(result, Right(true));
      verify(mockRepository.signOut());
    });

    test('should return false when user  try to logged in', () async {
      // arrange
      when(mockRepository.signOut()).thenAnswer((_) async => Right(false));
      // act
      final result = await userLogedOut.call(NoParams());
      // assert
      expect(result, Right(false));
    });
    test('should return a failure when check if user is logged in', () async {
      // arrange
      when(mockRepository.signOut())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await userLogedOut.call(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
    });
  });
}
