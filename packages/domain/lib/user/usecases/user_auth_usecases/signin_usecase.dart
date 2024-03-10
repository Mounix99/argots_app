import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecase_contract.dart';
import '../../repositories/user_auth_repository.dart';

class SignInUsecase implements Usecase<AuthResponse, Map<String, dynamic>> {
  final UserAuthRepository _userAuthRepository;

  SignInUsecase(this._userAuthRepository);

  @override
  Future<Either<Failure, AuthResponse>> call(Map<String, dynamic> params) async {
    return await _userAuthRepository.signInWithEmail(email: params['email'], password: params['password']);
  }
}
