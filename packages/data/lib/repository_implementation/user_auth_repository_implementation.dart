import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAuthRepositoryImplementation implements UserAuthRepository {
  UserAuthRepositoryImplementation({required this.supabase, required this.sharedPreferences});
  final Supabase supabase;
  final SharedPreferences sharedPreferences;

  static const String _sessionKey = 'user_session';

  @override
  Future<Either<Failure, AuthResponse>> signUpWithEmail(
      {required String email, required String password, Map<String, dynamic>? data}) async {
    try {
      final response = await supabase.client.auth.signUp(
        email: email,
        password: password,
        data: data,
      );
      if (response.session != null) {
        await sharedPreferences.setString(_sessionKey, response.session!.toJson().toString());
      }
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
      if (response.session != null) {
        await sharedPreferences.setString(_sessionKey, response.session!.toJson().toString());
      }
      return Right(response);
    } catch (error) {
      return Left(RemoteSourceFailure(remoteError: error));
    }
  }

  @override
  Future<Either<Failure, Success>> signOut() async {
    try {
      await supabase.client.auth.signOut();
      await sharedPreferences.remove(_sessionKey);
      return Right(RemoteSourceSuccess());
    } catch (error) {
      return Left(RemoteSourceFailure(remoteError: error));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signInWithToken() async {
    try {
      final sessionString = sharedPreferences.getString(_sessionKey);
      if (sessionString != null && supabase.client.auth.currentUser == null) {
        final response = await supabase.client.auth.recoverSession(sessionString);
        return Right(response);
      }
      return Future.value(const Left(RemoteSourceFailure(remoteError: 'No session found')));
    } catch (error) {
      return Future.value(Left(RemoteSourceFailure(remoteError: error.toString())));
    }
  }
}
