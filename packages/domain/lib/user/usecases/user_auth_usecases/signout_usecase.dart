import 'package:dartz/dartz.dart';
import 'package:domain/core/success_objects/success_object.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';

class SignOutUsecase implements UsecaseNoParam<Success> {
  final UserAuthRepository _userAuthRepository;

  SignOutUsecase(this._userAuthRepository);

  @override
  Future<Either<Failure, Success>> call() async {
    return await _userAuthRepository.signOut();
  }
}
