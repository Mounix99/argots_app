import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:domain/user/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/state_management/supabase_cubit/supabase_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserAuthRepository _userAuthRepository;
  final UserRepository _userRepository;

  ProfileCubit(this._userAuthRepository, this._userRepository) : super(ProfileState.initial()) {
    getUser();
  }

  Future<void> getUser() async {
    emit(state.copyWith(fetchUserState: RequestState.loading));
    final user = await _userRepository.getUser();
    user.fold((failure) => emit(state.copyWith(fetchUserState: RequestState.error, error: failure)),
        (user) => emit(state.copyWith(fetchUserState: RequestState.success, user: user)));
  }

  Future<void> signOut() async {
    emit(state.copyWith(signOutState: RequestState.loading));
    final result = await _userAuthRepository.signOut();
    result.fold((failure) => emit(state.copyWith(signOutState: RequestState.error, error: failure)),
        (_) => emit(state.copyWith(signOutState: RequestState.success)));
  }
}

class ProfileState extends Equatable {
  final User? user;
  final RequestState fetchUserState;
  final RequestState signOutState;
  final dynamic error;

  const ProfileState({required this.user, required this.fetchUserState, required this.signOutState, this.error});

  ProfileState copyWith({User? user, RequestState? fetchUserState, RequestState? signOutState, dynamic error}) {
    return ProfileState(
      user: user ?? this.user,
      fetchUserState: fetchUserState ?? this.fetchUserState,
      signOutState: signOutState ?? this.signOutState,
      error: error ?? this.error,
    );
  }

  factory ProfileState.initial() {
    return const ProfileState(
      user: null,
      fetchUserState: RequestState.initial,
      signOutState: RequestState.initial,
    );
  }

  @override
  List<Object?> get props => [user, fetchUserState, signOutState, error];
}
