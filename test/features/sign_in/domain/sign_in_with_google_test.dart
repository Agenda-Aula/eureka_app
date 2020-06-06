import 'package:app/core/error/Failure.dart';
import 'package:app/core/usecases/usecase.dart';
import 'package:app/features/sign_in/domain/sign_in_with_google.dart';
import 'package:app/features/sign_up/domain/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockRegisterUserRepository extends Mock implements UserRepository {}

void main() {
  SignInWithGoogle signInWithGoogle;
  MockRegisterUserRepository mockRepository;

  setUp(() {
    mockRepository = MockRegisterUserRepository();
    signInWithGoogle = SignInWithGoogle(repository: mockRepository);
  });

  test('should login with Google', () async {
    // arrange
    when(mockRepository.signInWithGoogle())
        .thenAnswer((_) async => Right(true));
    // act
    final result = await signInWithGoogle.call(NoParams());
    // assert
    verify(mockRepository.signInWithGoogle());
    expect(result, Right(true));
  });

  test('should return an failure from the repoistory', () async {
    // arrange
    final failure = ServerFailure();
    when(mockRepository.signInWithGoogle())
        .thenAnswer((_) async => Left(failure));
    // act
    final result = await signInWithGoogle.call(NoParams());
    // assert
    expect(result, Left(failure));
    verify(mockRepository.signInWithGoogle());
  });
}
