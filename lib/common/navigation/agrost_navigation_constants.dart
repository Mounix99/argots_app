import 'package:flutter/cupertino.dart';

enum Routes {
  splash('/'),

  /// Auth
  signIn('/sign_in'),
  signUp('/sign_up'),
  forgotPassword('/forgot_password'),
  resetPassword('/reset_password'),

  /// Home
  fields('/fields'),
  plants('/plants'),
  profile('/profile'),

  /// Plants
  userPlants('/user_plants'),
  marketPlace('/market_place'),

  /// Plant
  plantDetails('/plant_details');

  const Routes(this._path);

  final String _path;

  String get path => _path;

  /// Use this method to get the path with parameters
  /// Example: Routes.plantDetails.pathWithParams(':id')
  String pathWithParams(String params) => '$_path/$params';
}

class NavigationKeys {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: Routes.splash.name);
  static final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "home");
}
