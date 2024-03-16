import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserAuthRepository {
  Future<Either<Failure, AuthResponse>> signUpWithEmail(
      {required String email, required String password, Map<String, dynamic>? data});

  Future<Either<Failure, AuthResponse>> signInWithEmail({required String email, required String password});

  Future<Either<Failure, AuthResponse>> signInWithToken();

  Future<Either<Failure, Success>> signOut();
}
