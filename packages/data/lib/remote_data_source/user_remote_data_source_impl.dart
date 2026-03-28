import 'package:domain/user/entities/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'user_remote_data_source.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Supabase supabase;

  UserRemoteDataSourceImpl({required this.supabase});

  @override
  Future<AppUser?> getUser() async {
    final user = supabase.client.auth.currentUser;
    return user != null ? _toAppUser(user) : null;
  }

  @override
  Future<AppUser> updateUser(AppUser user) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(AppUser user) {
    throw UnimplementedError();
  }

  AppUser _toAppUser(User user) => AppUser(
        id: user.id,
        email: user.email ?? '',
        createdAt: user.createdAt.isNotEmpty ? DateTime.tryParse(user.createdAt) : null,
      );
}
