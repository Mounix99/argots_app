import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAuthRepositoryImplementation implements UserAuthRepository {
  UserAuthRepositoryImplementation({required this.supabase});
  final Supabase supabase;

  @override
  Future<Either<Failure, AuthResponse>> signUpWithEmail(
      {required String email, required String password, Map<String, dynamic>? data}) async {
    try {
      final response = await supabase.client.auth.signUp(
        email: email,
        password: password,
        data: data,
      );
      return Right(response);
    } catch (error) {
      return Left(RemoteSourceFailure(remoteError: error));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signInWithEmail({required String email, required String password}) async {
    try {
      final response = await supabase.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return Right(response);
    } catch (error) {
      return Left(RemoteSourceFailure(remoteError: error));
    }
  }
}
