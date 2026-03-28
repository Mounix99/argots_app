import 'package:domain/user/entities/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'user_auth_remote_data_source.dart';

class UserAuthRemoteDataSourceImpl implements UserAuthRemoteDataSource {
  final Supabase supabase;

  UserAuthRemoteDataSourceImpl({required this.supabase});

  @override
  AppUser? get currentUser {
    final user = supabase.client.auth.currentUser;
    return user != null ? _toAppUser(user) : null;
  }

  @override
  Stream<AppUser?> get authStateChanges => supabase.client.auth.onAuthStateChange
      .map((data) => data.session?.user != null ? _toAppUser(data.session!.user) : null);

  @override
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    final response = await supabase.client.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
    final user = response.user;
    if (user == null) {
      throw Exception('Sign up succeeded but no user was returned');
    }
    return _toAppUser(user);
  }

  @override
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await supabase.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) {
      throw Exception('Sign in succeeded but no user was returned');
    }
    return _toAppUser(user);
  }

  @override
  Future<void> signOut() async {
    await supabase.client.auth.signOut();
  }

  AppUser _toAppUser(User user) => AppUser(
        id: user.id,
        email: user.email ?? '',
        createdAt: user.createdAt.isNotEmpty ? DateTime.tryParse(user.createdAt) : null,
      );
}
