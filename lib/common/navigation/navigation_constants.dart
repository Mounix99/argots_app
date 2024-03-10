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
  profile('/profile');

  const Routes(this._path);

  final String _path;

  String get path => _path;
}

class NavigationKeys {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: Routes.splash.name);
  static final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "home");
}
