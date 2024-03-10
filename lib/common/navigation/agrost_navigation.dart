import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'navigation_constants.dart';

class AgrostNavigator {
  final BuildContext context;

  static AgrostNavigator of(BuildContext context) => AgrostNavigator(context);

  AgrostNavigator(this.context);

  void goToSplash() => context.goNamed(Routes.splash.name);

  void goToSignIn() => context.goNamed(Routes.signIn.name);

  void goToSignUp() => context.goNamed(Routes.signUp.name);

  void goToFields() => context.goNamed(Routes.fields.name);

  void goToPlants() => context.goNamed(Routes.plants.name);

  void goToProfile() => context.goNamed(Routes.profile.name);

  void goBack<T>() => context.pop<T>();
}
