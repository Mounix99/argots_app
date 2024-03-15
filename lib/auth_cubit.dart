import 'package:domain/user/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'common/state_management/supabase_cubit/supabase_cubit_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository _userRepository;

  AuthCubit(this._userRepository) : super(AuthState.initial()) {
    getUser();
  }

  Future<void> getUser() async {
    emit(state.copyWith(fetchUserState: RequestState.loading));
    final user = await _userRepository.getUser();
    user.fold((failure) => emit(state.copyWith(fetchUserState: RequestState.error, error: failure)),
        (user) => emit(state.copyWith(fetchUserState: RequestState.success, user: user)));
  }
}

class AuthState extends Equatable {
  final User? user;
  final RequestState fetchUserState;
  final dynamic error;

  const AuthState({required this.user, required this.fetchUserState, this.error});

  AuthState copyWith({User? user, RequestState? fetchUserState, dynamic error}) {
    return AuthState(
      user: user ?? this.user,
      fetchUserState: fetchUserState ?? this.fetchUserState,
      error: error ?? this.error,
    );
  }

  factory AuthState.initial() {
    return const AuthState(
      user: null,
      fetchUserState: RequestState.initial,
    );
  }

  @override
  List<Object?> get props => [user, fetchUserState, error];
}
