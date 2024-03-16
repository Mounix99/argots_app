import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:domain/user/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final UserAuthRepository _userAuthRepository;
  final UserRepository _userRepository;

  AuthCubit(this._userAuthRepository, this._userRepository) : super(AuthCubitState.initial()) {
    signInWithToken();
  }

  Future<void> getUser() async {
    emit(state.copyWith(fetchUserState: RequestState.loading));
    final user = await _userRepository.getUser();
    user.fold((failure) => emit(state.copyWith(fetchUserState: RequestState.error, error: failure)),
        (user) => emit(state.copyWith(fetchUserState: RequestState.success, user: user)));
  }

  Future<void> signInWithToken() async {
    emit(state.copyWith(loginWithTokenState: RequestState.loading));
    final response = await _userAuthRepository.signInWithToken();
    response.fold((failure) => emit(state.copyWith(loginWithTokenState: RequestState.error, error: failure)),
        (authResponse) => emit(state.copyWith(loginWithTokenState: RequestState.success, user: authResponse.user)));
  }
}

class AuthCubitState extends Equatable {
  final User? user;
  final RequestState fetchUserState;
  final RequestState loginWithTokenState;
  final dynamic error;

  const AuthCubitState(
      {required this.user, required this.fetchUserState, this.error, required this.loginWithTokenState});

  AuthCubitState copyWith(
      {User? user, RequestState? fetchUserState, RequestState? loginWithTokenState, dynamic error}) {
    return AuthCubitState(
      user: user ?? this.user,
      fetchUserState: fetchUserState ?? this.fetchUserState,
      loginWithTokenState: loginWithTokenState ?? this.loginWithTokenState,
      error: error ?? this.error,
    );
  }

  factory AuthCubitState.initial() {
    return const AuthCubitState(
      user: null,
      fetchUserState: RequestState.initial,
      loginWithTokenState: RequestState.initial,
    );
  }

  @override
  List<Object?> get props => [user, fetchUserState, loginWithTokenState, error];
}
