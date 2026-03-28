import 'package:data/repository_implementation/user_repository_implementation.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/user/entities/app_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:data/remote_data_source/user_remote_data_source.dart';

import 'user_repository_implementation_test.mocks.dart';

const _tUser = AppUser(id: 'user-1', email: 'test@example.com');

@GenerateNiceMocks([MockSpec<UserRemoteDataSource>(as: #MockUserRemoteDataSource)])
void main() {
  late MockUserRemoteDataSource mockDataSource;
  late UserRepositoryImplementation repository;

  setUp(() {
    provideDummy<Either<Failure, AppUser?>>(const Right(null));
    mockDataSource = MockUserRemoteDataSource();
    repository = UserRepositoryImplementation(remoteDataSource: mockDataSource);
  });

  group('UserRepositoryImplementation/getUser', () {
    test('/Success/ = returns AppUser when user is logged in', () async {
      when(mockDataSource.getUser()).thenAnswer((_) async => _tUser);

      final result = await repository.getUser();

      expect(result, const Right(_tUser));
    });

    test('/Success/ = returns null when no user is logged in', () async {
      when(mockDataSource.getUser()).thenAnswer((_) async => null);

      final result = await repository.getUser();

      expect(result, const Right(null));
    });

    test('/Failure/ = returns RemoteSourceFailure on exception', () async {
      when(mockDataSource.getUser()).thenThrow(Exception('auth error'));

      final result = await repository.getUser();

      expect(result.isLeft(), true);
    });
  });
}
