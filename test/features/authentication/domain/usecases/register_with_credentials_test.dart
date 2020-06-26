import 'package:app/core/error/failure.dart';
import 'package:app/features/authentication/domain/entities/auth.dart';
import 'package:app/features/authentication/domain/usecases/register_with_credentials.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'mock_authentication_repository.dart';

void main() {
  RegisterWithCredentials registerWithCredential;
  MockAuthenticationRepository mockAuthenticationRepository;
  Auth user;
  String email = "douglas@gmail.com";
  String password = "12345678";
  String profileUrl = "http://mypic.com";
  Params params;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    registerWithCredential =
        RegisterWithCredentials(repository: mockAuthenticationRepository);
    user = Auth(email, password, profileUrl);
    params = Params(email, password);
  });

  group('Register user repository tests', () {
    test('should register a user from  the repoistory', () async {
      // arrange
      when(mockAuthenticationRepository.registerWithCredentials(any, any))
          .thenAnswer((_) async => Right(user));
      // act
      final result = await registerWithCredential(params);
      // assert
      expect(result, Right(user));
      verify(mockAuthenticationRepository.registerWithCredentials(email, password));
      verifyNoMoreInteractions(mockAuthenticationRepository);
    });

    test('should return an failure from the repoistory', () async {
      // arrange
      final failure = ServerFailure();
      when(mockAuthenticationRepository.registerWithCredentials(any, any))
          .thenAnswer((_) async => Left(failure));
      // act
      final result = await registerWithCredential(Params(email, password));
      // assert
      expect(result, Left(failure));
      verify(mockAuthenticationRepository.registerWithCredentials(email, password));
      verifyNoMoreInteractions(mockAuthenticationRepository);
    });

    test('verify params property', () {
      expect('${[email, password]}', params.props.toString());
    });
  });
}
