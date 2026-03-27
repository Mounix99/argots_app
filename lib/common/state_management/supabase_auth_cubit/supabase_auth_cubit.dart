import 'package:agrost_app/common/extensions/future_extensions.dart';
import 'package:agrost_app/common/state_management/supabase_auth_cubit/supabase_auth_cubit_state.dart';
import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SupabaseAuthRequestCubit<T> extends Cubit<SupabaseAuthCubitState> {
  SupabaseAuthRequestCubit() : super(SupabaseAuthCubitState.initial());

  void emitLoading() {
    emit(state.copyWith(requestState: RequestState.loading, data: state.data));
  }

  void emitSuccess(T data) {
    emit(state.copyWith(requestState: RequestState.success, data: Right(data)));
  }

  void emitError(String errorMessage) {
    emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: errorMessage,
        data: Left(RemoteSourceFailure(remoteError: errorMessage))));
  }

  @protected
  void onSuccess() {}

  @protected
  void onFail() {}

  @protected
  Future<Either<Failure, T?>> requestData(Future<Either<Failure, T?>> Function() request) async {
    emitLoading();
      return request().withProgress().then((result) {
      emit(result.match(
        (failure) {
          onFail();
          return state.copyWith(requestState: RequestState.error, errorMessage: failure.error.toString());
        },
        (data) {
          onSuccess();
          return state.copyWith(requestState: RequestState.success, data: state.data);
        },
      ));
      return result;
    });
  }
}
