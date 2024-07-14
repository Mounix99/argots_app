import 'package:agrost_app/common/theming/agrost_main_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'common/dependency_injection/dependency_injection_service.dart';
import 'common/navigation/agrost_router.dart';
import 'package:flutter_gen/gen_l10n/agrost_localizations.dart';

import 'features/authentication/auth_cubit.dart';

void main() async {
  await DIService.init();
  runApp(AgrostApp.create());
}

class AgrostApp extends StatelessWidget {
  AgrostApp({super.key});

  static Widget create() {
    return BlocProvider(create: (context) => AuthCubit(DIService.get(), DIService.get()), child: AgrostApp());
  }

  final router = AgrostRouter(DIService.get()).router;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthCubitState>(
      builder: (_, __) => MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: EasyLoading.init(),
        theme: AgrostTheming.lightTheme,
        darkTheme: AgrostTheming.darkTheme,
      ),
    );
  }
}
