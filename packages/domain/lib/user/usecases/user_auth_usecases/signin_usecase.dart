import 'package:fpdart/fpdart.dart';
import 'package:domain/user/entities/app_user.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/user_auth_repository.dart';

typedef SignInParams = ({String email, String password});

class SignInUseCase implements UseCase<AppUser, SignInParams> {
  final UserAuthRepository _userAuthRepository;

  SignInUseCase(this._userAuthRepository);

  @override
  Future<Either<Failure, AppUser>> call(SignInParams params) async {
    return await _userAuthRepository.signInWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}
