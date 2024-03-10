import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'common/dependency_injection/dependency_injection_service.dart';
import 'common/navigation/agrost_router.dart';
import 'package:flutter_gen/gen_l10n/agrost_localizations.dart';

void main() async {
  await DIService.init();
  runApp(const AgrostApp());
}

class AgrostApp extends StatelessWidget {
  const AgrostApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AgrostRouter(DIService.get()).router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: EasyLoading.init(),
    );
  }
}
