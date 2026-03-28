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

class FormRequestState extends Equatable {
  const FormRequestState({
    required this.requestState,
    this.errorMessage,
  });

  final RequestState requestState;
  final String? errorMessage;

  factory FormRequestState.initial() => const FormRequestState(
        requestState: RequestState.initial,
      );

  FormRequestState copyWith({
    RequestState? requestState,
    String? errorMessage,
  }) =>
      FormRequestState(
        requestState: requestState ?? this.requestState,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [requestState, errorMessage];
}
