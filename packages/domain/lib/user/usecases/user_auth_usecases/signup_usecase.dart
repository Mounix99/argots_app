import 'package:fpdart/fpdart.dart';
import 'package:domain/user/entities/app_user.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/user_auth_repository.dart';

typedef SignUpParams = ({String email, String password, Map<String, dynamic>? data});

class SignUpUseCase implements UseCase<AppUser, SignUpParams> {
  final UserAuthRepository _userAuthRepository;

  SignUpUseCase(this._userAuthRepository);

  @override
  Future<Either<Failure, AppUser>> call(SignUpParams params) async {
    return await _userAuthRepository.signUpWithEmail(
      email: params.email,
      password: params.password,
      data: params.data,
    );
  }
}
