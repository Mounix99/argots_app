import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/repositories/user_repository.dart';

import '../remote_data_source/user_remote_data_source.dart';

class UserRepositoryImplementation implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImplementation({required UserRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, AppUser?>> getUser() async {
    try {
      final user = await _remoteDataSource.getUser();
      return Right(user);
    } catch (e) {
      return Left(RemoteSourceFailure(remoteError: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppUser>> updateUser(AppUser user) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AppUser>> deleteUser(AppUser user) {
    throw UnimplementedError();
  }
}
