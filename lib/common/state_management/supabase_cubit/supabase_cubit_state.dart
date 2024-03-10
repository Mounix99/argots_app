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

class SupabaseCubitState extends Equatable {
  final RequestState requestState;
  final String? errorMessage;
  final dynamic data;

  const SupabaseCubitState({
    required this.requestState,
    this.errorMessage,
    this.data,
  });

  factory SupabaseCubitState.initial() {
    return const SupabaseCubitState(
      requestState: RequestState.initial,
    );
  }

  SupabaseCubitState copyWith({
    RequestState? requestState,
    String? errorMessage,
    dynamic data,
  }) {
    return SupabaseCubitState(
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [requestState, errorMessage, data];
}
