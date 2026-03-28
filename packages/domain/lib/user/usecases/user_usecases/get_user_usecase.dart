import 'package:fpdart/fpdart.dart';
import 'package:domain/user/entities/app_user.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/user_repository.dart';

class GetUserUsecase implements UsecaseNoParam<AppUser?> {
  final UserRepository userRepository;

  GetUserUsecase(this.userRepository);

  @override
  Future<Either<Failure, AppUser?>> call() async {
    return userRepository.getUser();
  }
}
