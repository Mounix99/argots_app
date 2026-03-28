import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/user/entities/app_user.dart';

abstract class UserAuthRepository {
  AppUser? get currentUser;

  Stream<AppUser?> get authStateChanges;

  Future<Either<Failure, AppUser>> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  });

  Future<Either<Failure, AppUser>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, Success>> signOut();
}
