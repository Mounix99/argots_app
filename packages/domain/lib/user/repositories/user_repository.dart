import 'package:dartz/dartz.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserRepository {
  Future<Either<Failure, User?>> getUser();
  Future<Either<Failure, User>> updateUser(User user);
  Future<Either<Failure, User>> deleteUser(User user);
}
