import 'package:equatable/equatable.dart';

enum RequestState {
  initial,
  loading,
  success,
  error;

  bool get isLoading => this == RequestState.loading;
  bool get isSuccess => this == RequestState.success;
  bool get isError => this == RequestState.error;
  bool get isInitial => this == RequestState.initial;
}

class SupabaseAuthCubitState extends Equatable {
  final RequestState requestState;
  final String? errorMessage;
  final dynamic data;

  const SupabaseAuthCubitState({
    required this.requestState,
    this.errorMessage,
    this.data,
  });

  factory SupabaseAuthCubitState.initial() {
    return const SupabaseAuthCubitState(
      requestState: RequestState.initial,
    );
  }

  SupabaseAuthCubitState copyWith({
    RequestState? requestState,
    String? errorMessage,
    dynamic data,
  }) {
    return SupabaseAuthCubitState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [requestState, errorMessage, data];
}
