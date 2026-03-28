import 'package:fpdart/fpdart.dart';
import 'package:domain/user/entities/app_user.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/user_auth_repository.dart';

class SignInUsecase implements Usecase<AppUser, Map<String, dynamic>> {
  final UserAuthRepository _userAuthRepository;

  SignInUsecase(this._userAuthRepository);

  @override
  Future<Either<Failure, AppUser>> call(Map<String, dynamic> params) async {
    return await _userAuthRepository.signInWithEmail(
      email: params['email'],
      password: params['password'],
    );
  }
}
