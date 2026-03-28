import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../extensions/context_extensions.dart';
import '../state_management/base/request_state.dart';

/// A generic BlocListener that reacts to any state with a [RequestState] error
/// and shows a snackbar with the error message.
///
/// [S] must expose [requestState] and [errorMessage]. Use [listenWhen] to map
/// any cubit state to [ErrorListenerState].
class ErrorCubitListener<C extends Cubit<S>, S extends Equatable> extends StatelessWidget {
  const ErrorCubitListener({
    super.key,
    required this.child,
    required this.requestStateSelector,
    required this.errorMessageSelector,
    this.onError,
    this.onSuccess,
  });

  final Widget child;
  final RequestState Function(S state) requestStateSelector;
  final String? Function(S state) errorMessageSelector;
  final void Function(BuildContext context, S state)? onError;
  final void Function(BuildContext context, S state)? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocListener<C, S>(
      listenWhen: (previous, current) =>
          requestStateSelector(previous) != requestStateSelector(current),
      listener: (context, state) {
        final requestState = requestStateSelector(state);
        if (requestState.isError) {
          final message = errorMessageSelector(state);
          if (message != null) {
            context.showSnackBar(message: message);
          }
          onError?.call(context, state);
        } else if (requestState.isSuccess) {
          onSuccess?.call(context, state);
        }
      },
      child: child,
    );
  }
}
