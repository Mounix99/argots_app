import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/agrost_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth_cubit.dart';
import '../navigation/agrost_navigation.dart';

extension OfContext on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this)!;

  ThemeData get theme => Theme.of(this);

  FocusScopeNode get focus => FocusScope.of(this);

  AgrostNavigator get navigator => AgrostNavigator.of(this);

  AuthCubit get authCubit => BlocProvider.of<AuthCubit>(this);

  User? get user => authCubit.state.user;

  void showSnackBar({
    required String message,
    Widget? child,
    SnackBarAction? action,
    Duration duration = const Duration(seconds: 3),
    bool hidePrevious = true,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: child ?? Text(message),
          duration: duration,
          action: action,
        ),
      );
  }
}
