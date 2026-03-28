import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:domain/user/entities/app_user.dart';

abstract class UserRepository {
  Future<Either<Failure, AppUser?>> getUser();
  Future<Either<Failure, AppUser>> updateUser(AppUser user);
  Future<Either<Failure, AppUser>> deleteUser(AppUser user);
}
