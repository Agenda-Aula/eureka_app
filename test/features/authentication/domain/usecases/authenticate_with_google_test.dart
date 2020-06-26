import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/use_case.dart';
import 'package:app/features/authentication/domain/usecases/authenticate_with_google.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_authentication_repository.dart';

void main() {
  SignInWithGoogle signInWithGoogle;
  MockAuthenticationRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthenticationRepository();
    signInWithGoogle = SignInWithGoogle(repository: mockRepository);
  });

  test('should login with Google', () async {
    // arrange
    when(mockRepository.authenticateWithGoogle())
        .thenAnswer((_) async => Right(true));
    // act
    final result = await signInWithGoogle.call(NoParams());
    // assert
    verify(mockRepository.authenticateWithGoogle());
    expect(result, Right(true));
  });

  test('should return an failure from the repository', () async {
    // arrange
    final failure = ServerFailure();
    when(mockRepository.authenticateWithGoogle())
        .thenAnswer((_) async => Left(failure));
    // act
    final result = await signInWithGoogle.call(NoParams());
    // assert
    expect(result, Left(failure));
    verify(mockRepository.authenticateWithGoogle());
  });
}
