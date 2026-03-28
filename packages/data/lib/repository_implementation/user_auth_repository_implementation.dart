import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../remote_data_source/user_auth_remote_data_source.dart';

class UserAuthRepositoryImplementation implements UserAuthRepository {
  final UserAuthRemoteDataSource _remoteDataSource;

  UserAuthRepositoryImplementation({required UserAuthRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  AppUser? get currentUser => _remoteDataSource.currentUser;

  @override
  Stream<AppUser?> get authStateChanges => _remoteDataSource.authStateChanges;

  @override
  Future<Either<Failure, AppUser>> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final user = await _remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        data: data,
      );
      return Right(user);
    } catch (error) {
      final message = error is AuthException ? error.message : error.toString();
      return Left(RemoteSourceFailure(remoteError: message));
    }
  }

  @override
  Future<Either<Failure, AppUser>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (error) {
      final message = error is AuthException ? error.message : error.toString();
      return Left(RemoteSourceFailure(remoteError: message));
    }
  }

  @override
  Future<Either<Failure, Success>> signOut() async {
    try {
      await _remoteDataSource.signOut();
      return Right(RemoteSourceSuccess());
    } catch (error) {
      return Left(RemoteSourceFailure(remoteError: error.toString()));
    }
  }
}
