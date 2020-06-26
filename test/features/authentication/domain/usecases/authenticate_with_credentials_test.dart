import 'package:app/core/error/failure.dart';
import 'package:app/features/authentication/domain/usecases/authenticate_with_credentials.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_authentication_repository.dart';

void main() {
  AuthenticateWithCredentials signInWithCredentials;
  MockAuthenticationRepository mockRepository;
  String email = "douglas@gmail.com";
  String password = "12345678";
  Params params;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    signInWithCredentials =
        AuthenticateWithCredentials(repository: mockRepository);
    params = Params(email, password);
  });

  test('should login with credentials', () async {
    // arrange
    when(mockRepository.authenticateWithCredentials(any, any))
        .thenAnswer((_) async => Right(true));
    // act
    final result = await signInWithCredentials.call(params);
    // assert
    verify(mockRepository.authenticateWithCredentials(email, password));
    expect(result, Right(true));
  });

  test('should return an failure from the repoistory', () async {
    // arrange
    final failure = ServerFailure();
    when(mockRepository.authenticateWithCredentials(any, any))
        .thenAnswer((_) async => Left(failure));
    // act
    final result = await signInWithCredentials.call(params);
    // assert
    expect(result, Left(failure));
    verify(mockRepository.authenticateWithCredentials(email, password));
  });
}
