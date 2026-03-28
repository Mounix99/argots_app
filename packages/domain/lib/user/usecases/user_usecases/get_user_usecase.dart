import 'package:fpdart/fpdart.dart';
import 'package:domain/user/entities/app_user.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/user_repository.dart';

class GetUserUseCase implements UseCaseNoParam<AppUser?> {
  final UserRepository userRepository;

  GetUserUseCase(this.userRepository);

  @override
  Future<Either<Failure, AppUser?>> call() async {
    return userRepository.getUser();
  }
}
