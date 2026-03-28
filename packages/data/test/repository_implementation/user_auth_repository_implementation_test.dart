import 'package:data/repository_implementation/user_auth_repository_implementation.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/user/entities/app_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:data/remote_data_source/user_auth_remote_data_source.dart';

import 'user_auth_repository_implementation_test.mocks.dart';

const _tUser = AppUser(id: 'user-1', email: 'test@example.com');

@GenerateNiceMocks([MockSpec<UserAuthRemoteDataSource>(as: #MockUserAuthRemoteDataSource)])
void main() {
  late MockUserAuthRemoteDataSource mockDataSource;
  late UserAuthRepositoryImplementation repository;

  setUp(() {
    provideDummy<Either<Failure, AppUser>>(Right(_tUser));
    provideDummy<Either<Failure, Success>>(Right(RemoteSourceSuccess()));
    mockDataSource = MockUserAuthRemoteDataSource();
    repository = UserAuthRepositoryImplementation(remoteDataSource: mockDataSource);
  });

  group('UserAuthRepositoryImplementation/signInWithEmail', () {
    test('/Success/ = returns AppUser on success', () async {
      when(mockDataSource.signInWithEmail(email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => _tUser);

      final result = await repository.signInWithEmail(email: 'test@example.com', password: 'pass123');

      expect(result, Right(_tUser));
    });

    test('/Failure/ = returns RemoteSourceFailure on exception', () async {
      when(mockDataSource.signInWithEmail(email: anyNamed('email'), password: anyNamed('password')))
          .thenThrow(Exception('invalid credentials'));

      final result = await repository.signInWithEmail(email: 'test@example.com', password: 'wrong');

      expect(result.isLeft(), true);
    });
  });

  group('UserAuthRepositoryImplementation/signUpWithEmail', () {
    test('/Success/ = returns AppUser on success', () async {
      when(mockDataSource.signUpWithEmail(
              email: anyNamed('email'), password: anyNamed('password'), data: anyNamed('data')))
          .thenAnswer((_) async => _tUser);

      final result = await repository.signUpWithEmail(email: 'new@example.com', password: 'pass123');

      expect(result, Right(_tUser));
    });

    test('/Failure/ = returns RemoteSourceFailure on exception', () async {
      when(mockDataSource.signUpWithEmail(
              email: anyNamed('email'), password: anyNamed('password'), data: anyNamed('data')))
          .thenThrow(Exception('email already in use'));

      final result = await repository.signUpWithEmail(email: 'taken@example.com', password: 'pass123');

      expect(result.isLeft(), true);
    });
  });

  group('UserAuthRepositoryImplementation/signOut', () {
    test('/Success/ = returns Success when sign out succeeds', () async {
      when(mockDataSource.signOut()).thenAnswer((_) async {});

      final result = await repository.signOut();

      expect(result, Right(RemoteSourceSuccess()));
    });

    test('/Failure/ = returns RemoteSourceFailure on exception', () async {
      when(mockDataSource.signOut()).thenThrow(Exception('network error'));

      final result = await repository.signOut();

      expect(result.isLeft(), true);
    });
  });

  group('UserAuthRepositoryImplementation/currentUser', () {
    test('delegates to data source', () {
      when(mockDataSource.currentUser).thenReturn(_tUser);

      expect(repository.currentUser, _tUser);
    });

    test('returns null when not logged in', () {
      when(mockDataSource.currentUser).thenReturn(null);

      expect(repository.currentUser, isNull);
    });
  });
}
