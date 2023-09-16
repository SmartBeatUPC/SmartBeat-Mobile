import 'package:flutter/cupertino.dart';
import 'package:smartbeat_frontend/home/screens/home_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/screens/login_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/splash/screens/splash_screen.dart';
import 'package:smartbeat_frontend/shared/extensions/extension_dynamic.dart';

class CustomRoute {
  static Map<String, Widget Function(RouteSettings)> routes =
      <String, Widget Function(RouteSettings)>{
    SplashScreen.route: (settings) => const SplashScreen(),
    LoginScreen.route: (settings) => const LoginScreen(),
    HomeScreen.route: (settings) => const HomeScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (_) => routes[settings.name]!(settings));
  }
}
