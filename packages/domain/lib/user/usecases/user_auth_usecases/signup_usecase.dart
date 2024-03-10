import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/user_auth_repository.dart';

class SignUpUsecase implements Usecase<AuthResponse, Map<String, dynamic>> {
  final UserAuthRepository _userAuthRepository;

  SignUpUsecase(this._userAuthRepository);

  @override
  Future<Either<Failure, AuthResponse>> call(Map<String, dynamic> params) async {
    return await _userAuthRepository.signUpWithEmail(
        email: params['email'], password: params['password'], data: params['data']);
  }
}
