import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sihati/features/auth/presentation/pages/login_screen.dart';
import 'package:sihati/features/auth/presentation/pages/signin_screen.dart';
import 'package:sihati/features/dashboard/dashboard_screen.dart';
import 'package:sihati/features/splash/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  //! splashScreen
  static const String splash = '/';
  //! onboarding
  static const String onboarding = '/onboarding';
  //! auth
  static const String login = '/login';
  static const String register = '/register';
  //! home
  static const String home = '/home';
  //! dashboard
  static const String dashboard = '/dashboard';
  

  static final GoRouter route = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: login, builder: (context, state)  {
        return LoginScreen();
      }),
      GoRoute(path: register, builder: (context, state) =>  SigninScreen()),
      GoRoute(path: dashboard, builder: (context, state) => const DashboardScreen()),
    ],
  );
}
