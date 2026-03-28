import 'dart:async';

import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  AppUser? get user => null;
  bool get isAuthenticated => false;
  bool get isUnknown => false;
}

final class AuthUnknown extends AuthState {
  const AuthUnknown();

  @override
  bool get isUnknown => true;

  @override
  List<Object?> get props => [];
}

final class Authenticated extends AuthState {
  const Authenticated(this._user);

  final AppUser _user;

  @override
  AppUser get user => _user;

  @override
  bool get isAuthenticated => true;

  @override
  List<Object?> get props => [_user];
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  List<Object?> get props => [];
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthUnknown()) {
    _initialize();
  }

  final UserAuthRepository _authRepository;
  late final StreamSubscription<AppUser?> _authSubscription;

  void _initialize() {
    final currentUser = _authRepository.currentUser;
    if (currentUser != null) {
      emit(Authenticated(currentUser));
    }

    _authSubscription = _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(const Unauthenticated());
      }
    });
  }

  Future<void> signOut() => _authRepository.signOut();

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
