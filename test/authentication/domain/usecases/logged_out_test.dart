import 'package:app/authentication/domain/usecases/is_logged_in.dart';
import 'package:app/authentication/domain/usecases/logged_out.dart';
import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'is_logged_in_test.dart';

void main() {
  UserLoggedOut usecase;
  MockUserRepository mockRepository;
  String email = "douglas@gmail.com";
  String password = "12345678";
  Params params;

  setUp(() {
    mockRepository = MockUserRepository();
    usecase = UserLoggedOut(repository: mockRepository);
    params = Params(email, password);
  });

  group('Group', () {
    test('should return true when user  sign out', () async {
      // arrange
      when(mockRepository.signOut()).thenAnswer((_) async => Right(true));
      // act
      final result = await usecase.call(NoParams());
      // assert
      expect(result, Right(true));
      verify(mockRepository.signOut());
    });

    test('should return false when user  try to logged in', () async {
      // arrange
      when(mockRepository.signOut()).thenAnswer((_) async => Right(false));
      // act
      final result = await usecase.call(NoParams());
      // assert
      expect(result, Right(false));
    });
    test('should return a failure when check if user is logged in', () async {
      // arrange
      when(mockRepository.signOut())
          .thenAnswer((_) async => Left(ServerFailure()));
      // act
      final result = await usecase.call(NoParams());
      // assert
      expect(result, Left(ServerFailure()));
    });

    test('verify params property', () {
      expect('${[email, password]}', params.props.toString());
    });
  });
}
