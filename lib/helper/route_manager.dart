import 'package:go_router/go_router.dart';
import 'package:myweb/screen/home_screen.dart';
import 'package:myweb/screen/splash_screen.dart';

class RouteManager {
  static final RouteManager _manager = RouteManager._instance();

  factory RouteManager() {
    return _manager;
  }

  RouteManager._instance();

  GoRouter router = GoRouter(initialLocation: "/home", routes: [
    GoRoute(path: "/", builder: (context, state) => const SplashScreen()),
    GoRoute(path: "/home", builder: (context, state) => const HomeScreen())
  ]);
}
