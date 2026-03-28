import 'package:agrost_app/common/state_management/base/request_state.dart';
import 'package:fpdart/fpdart.dart';
import 'package:domain/core/errors/failure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FormRequestCubit<T> extends Cubit<FormRequestState> {
  FormRequestCubit() : super(FormRequestState.initial());

  @protected
  Future<Either<Failure, T>> requestData(
    Future<Either<Failure, T>> Function() request,
  ) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await request();
    result.match(
      (failure) => emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: failure.error.toString(),
      )),
      (_) => emit(state.copyWith(requestState: RequestState.success)),
    );
    return result;
  }
}
