import 'package:domain/user/entities/app_user.dart';

abstract class UserRemoteDataSource {
  Future<AppUser?> getUser();

  Future<AppUser> updateUser(AppUser user);

  Future<void> deleteUser(AppUser user);
}
