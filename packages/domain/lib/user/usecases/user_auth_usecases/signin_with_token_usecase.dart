import 'package:dartz/dartz.dart';
import 'package:domain/core/usecase_contract.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/failure.dart';
import '../../repositories/user_auth_repository.dart';

class SignInWithTokenUsecase implements UsecaseNoParam<AuthResponse> {
  final UserAuthRepository _userAuthRepository;

  SignInWithTokenUsecase(this._userAuthRepository);

  @override
  Future<Either<Failure, AuthResponse>> call() async {
    return await _userAuthRepository.signInWithToken();
  }
}
