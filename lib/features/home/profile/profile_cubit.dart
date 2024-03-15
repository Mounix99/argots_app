import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/state_management/supabase_cubit/supabase_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserAuthRepository _userAuthRepository;

  ProfileCubit(this._userAuthRepository) : super(ProfileState.initial());

  Future<void> signOut() async {
    emit(state.copyWith(signOutState: RequestState.loading));
    final result = await _userAuthRepository.signOut();
    result.fold((failure) => emit(state.copyWith(signOutState: RequestState.error, error: failure)),
        (_) => emit(state.copyWith(signOutState: RequestState.success)));
  }
}

class ProfileState extends Equatable {
  final RequestState signOutState;
  final dynamic error;

  const ProfileState({required this.signOutState, this.error});

  ProfileState copyWith({RequestState? signOutState, dynamic error}) {
    return ProfileState(
      signOutState: signOutState ?? this.signOutState,
      error: error ?? this.error,
    );
  }

  factory ProfileState.initial() {
    return const ProfileState(
      signOutState: RequestState.initial,
    );
  }

  @override
  List<Object?> get props => [signOutState, error];
}
