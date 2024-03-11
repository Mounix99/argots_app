import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/user/repositories/user_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepositoryImplementation extends UserRepository {
  UserRepositoryImplementation({required this.supabase});
  final Supabase supabase;

  @override
  Future<Either<Failure, User?>> getUser() {
    try {
      final user = supabase.client.auth.currentUser;
      return Future.value(Right(user));
    } catch (e) {
      return Future.value(Left(RemoteSourceFailure(remoteError: e.toString())));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> deleteUser(User user) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
