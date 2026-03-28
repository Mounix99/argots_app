import 'dart:async';

import 'package:agrost_app/features/authentication/signin/signin_screen.dart';
import 'package:agrost_app/features/authentication/signup/signup_screen.dart';
import 'package:agrost_app/features/home/plants/plants_page.dart';
import 'package:domain/user/entities/app_user.dart';
import 'package:domain/user/repositories/user_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/fields/fields_page.dart';
import '../../features/home/home_screen.dart';
import '../../features/home/plants/plant_market/plant_market_page.dart';
import '../../features/home/plants/user_plants_list/user_plants_list_page.dart';
import '../../features/home/profile/profile_page.dart';
import '../../features/plant/create_plant/create_plant_screen.dart';
import '../../features/plant/plant_details/added_plant_details_screen.dart';
import '../../features/splash/splash_screen.dart';
import 'agrost_navigation_constants.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<Object?> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AgrostRouter {
  AgrostRouter(this._authRepository);

  final UserAuthRepository _authRepository;

  late final GoRouter router = GoRouter(
    initialLocation: Routes.splash.path,
    navigatorKey: NavigationKeys.rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(_authRepository.authStateChanges),
    redirect: (context, state) {
      final AppUser? user = _authRepository.currentUser;
      final location = state.matchedLocation;

      final isOnSplash = location == Routes.splash.path;
      final isOnAuthScreen = location == Routes.signIn.path || location == Routes.signUp.path;

      if (isOnSplash) {
        return user != null
            ? state.namedLocation(Routes.fields.name)
            : state.namedLocation(Routes.signIn.name);
      }

      if (user == null && !isOnAuthScreen) {
        return state.namedLocation(Routes.signIn.name);
      }
      if (user != null && isOnAuthScreen) {
        return state.namedLocation(Routes.fields.name);
      }
      return null;
    },
    routes: [
      /// Auth routes
      GoRoute(
        name: Routes.splash.name,
        path: Routes.splash.path,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: Routes.signUp.name,
        path: Routes.signUp.path,
        builder: (context, state) => SignUpScreen.create(),
      ),
      GoRoute(
        name: Routes.signIn.name,
        path: Routes.signIn.path,
        builder: (context, state) => SignInScreen.create(),
      ),

      /// Home routes
      StatefulShellRoute(
        parentNavigatorKey: NavigationKeys.rootNavigatorKey,
        builder: (_, _, shell) => shell,
        navigatorContainerBuilder: (_, shellNavigator, children) => HomeNavigation(
          navigationShell: shellNavigator,
          children: children,
        ),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              name: Routes.fields.name,
              path: Routes.fields.path,
              builder: (context, state) => const FieldsPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            StatefulShellRoute(
                builder: (_, _, shell) => shell,
                navigatorContainerBuilder: (_, shell, children) =>
                    PlantsScreen.create(shell: shell, children: children),
                branches: [
                  StatefulShellBranch(routes: [
                    GoRoute(
                        name: Routes.userPlants.name,
                        path: Routes.userPlants.path,
                        builder: (context, state) => MyPlantsPage.create()),
                  ]),
                  StatefulShellBranch(routes: [
                    GoRoute(
                      name: Routes.marketPlace.name,
                      path: Routes.marketPlace.path,
                      builder: (context, state) => PlantMarketPage.create(),
                    ),
                  ]),
                ]),
            TransitionGoRoute(
              name: Routes.plantDetails.name,
              path: Routes.plantDetails.pathWithParams(":id"),
              transitionType: TransitionType.slide,
              pageBuilder: (context, state) =>
                  AddedPlantDetailsScreen.create(plantId: int.parse(state.pathParameters['id']!)),
            ),
            TransitionGoRoute(
              name: Routes.createPlant.name,
              path: Routes.createPlant.path,
              transitionType: TransitionType.slide,
              pageBuilder: (context, state) => CreatePlantScreen.create(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              name: Routes.profile.name,
              path: Routes.profile.path,
              builder: (context, state) => ProfilePage.create(),
            ),
          ]),
        ],
      )
    ],
  );
}

enum TransitionType { fade, rotation, size, slide, scale }

class TransitionGoRoute extends GoRoute {
  TransitionGoRoute({
    required super.name,
    required super.path,
    required TransitionType transitionType,
    required Widget Function(BuildContext, GoRouterState) pageBuilder,
  }) : super(
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            transitionDuration: const Duration(milliseconds: 300),
            child: pageBuilder(context, state),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              switch (transitionType) {
                case TransitionType.fade:
                  return FadeTransition(opacity: animation, child: child);
                case TransitionType.rotation:
                  return RotationTransition(turns: animation, child: child);
                case TransitionType.size:
                  return SizeTransition(sizeFactor: animation, child: child);
                case TransitionType.scale:
                  return ScaleTransition(scale: animation, child: child);
                case TransitionType.slide:
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
              }
            },
          ),
        );
}
