import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepositoryImplementation extends UserRepository {
  UserRepositoryImplementation({required this.supabase});

  final Supabase supabase;

  @override
  Future<Either<Failure, AppUser?>> getUser() {
    try {
      final user = supabase.client.auth.currentUser;
      return Future.value(Right(user != null ? _toAppUser(user) : null));
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e.toString())));
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

  AppUser _toAppUser(User user) => AppUser(
        id: user.id,
        email: user.email ?? '',
        createdAt: user.createdAt.isNotEmpty ? DateTime.tryParse(user.createdAt) : null,
      );
}
