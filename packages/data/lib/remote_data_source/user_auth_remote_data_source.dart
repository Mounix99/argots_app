import 'package:domain/user/entities/app_user.dart';

abstract class UserAuthRemoteDataSource {
  AppUser? get currentUser;

  Stream<AppUser?> get authStateChanges;

  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  });

  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
