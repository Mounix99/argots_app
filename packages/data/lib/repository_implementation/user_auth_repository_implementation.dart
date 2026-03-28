import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAuthRepositoryImplementation implements UserAuthRepository {
  UserAuthRepositoryImplementation({required this.supabase});

  final Supabase supabase;

  @override
  AppUser? get currentUser {
    final user = supabase.client.auth.currentUser;
    return user != null ? _toAppUser(user) : null;
  }

  @override
  Stream<AppUser?> get authStateChanges => supabase.client.auth.onAuthStateChange
      .map((data) => data.session?.user != null ? _toAppUser(data.session!.user) : null);

  @override
  Future<Either<Failure, AppUser>> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await supabase.client.auth.signUp(
        email: email,
        password: password,
        data: data,
      );
      final user = response.user;
      if (user == null) {
        return const Left(RemoteSourceFailure(remoteError: 'Sign up succeeded but no user was returned'));
      }
      return Right(_toAppUser(user));
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
      final response = await supabase.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        return const Left(RemoteSourceFailure(remoteError: 'Sign in succeeded but no user was returned'));
      }
      return Right(_toAppUser(user));
    } catch (error) {
      final message = error is AuthException ? error.message : error.toString();
      return Left(RemoteSourceFailure(remoteError: message));
    }
  }

  @override
  Future<Either<Failure, Success>> signOut() async {
    try {
      await supabase.client.auth.signOut();
      return Right(RemoteSourceSuccess());
    } catch (error) {
      return Left(RemoteSourceFailure(remoteError: error.toString()));
    }
  }

  AppUser _toAppUser(User user) => AppUser(
        id: user.id,
        email: user.email ?? '',
        createdAt: user.createdAt.isNotEmpty ? DateTime.tryParse(user.createdAt) : null,
      );
}
