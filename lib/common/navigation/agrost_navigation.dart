import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import 'argost_navigation_constants.dart';

class AgrostNavigator {
  final BuildContext context;

  static AgrostNavigator of(BuildContext context) => AgrostNavigator(context);

  AgrostNavigator(this.context);

  void goToSplash() => context.goNamed(Routes.splash.name);

  /// Auth
  void goToSignIn() => context.goNamed(Routes.signIn.name);

  void goToSignUp() => context.goNamed(Routes.signUp.name);

  /// Home
  void goToFields() => context.goNamed(Routes.fields.name);

  void goToProfile() => context.goNamed(Routes.profile.name);

  /// Plants
  void goToUserPlants() => context.pushNamed(Routes.userPlants.name);

  void goToMarketPlace() => context.pushNamed(Routes.marketPlace.name);

  /// Plant
  void goToPlantDetails(String id) => context.pushNamed(Routes.plantDetails.name, pathParameters: {'id': id});

  void goBack<T>() => context.pop<T>();
}
