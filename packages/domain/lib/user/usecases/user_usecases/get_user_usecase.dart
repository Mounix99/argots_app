import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/user_repository.dart';

class GetUserUsecase implements UsecaseNoParam<User?> {
  final UserRepository userRepository;

  GetUserUsecase(this.userRepository);

  @override
  Future<Either<Failure, User?>> call() async {
    return userRepository.getUser();
  }
}
