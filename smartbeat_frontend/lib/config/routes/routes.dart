import 'package:flutter/cupertino.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_paciente_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/seleccion_paciente_medico_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/inicio/screens/inicio_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/screens/login_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/registro_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/splash/screens/splash_screen.dart';
import 'package:smartbeat_frontend/shared/extensions/extension_dynamic.dart';

class CustomRoute {
  static Map<String, Widget Function(RouteSettings)> routes =
      <String, Widget Function(RouteSettings)>{
    SplashScreen.route: (settings) => const SplashScreen(),
    InicioScreen.route: (settings) => const InicioScreen(),
    LoginScreen.route: (settings) => const LoginScreen(),
    RegistroScreen.route: (settings) => const RegistroScreen(),
    HomeNavBarScreen.route: (settings) => HomeNavBarScreen(),
    SeleccionPacienteMedicoScreen.route: (settings) =>
        const SeleccionPacienteMedicoScreen(),
    DatosPersonalesPacienteScreen.route: (settings) {
      final args =
          settings.arguments.castOr<DatosPersonalesPacienteScreenArgs>()!;
      return DatosPersonalesPacienteScreen(args: args);
    },
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (_) => routes[settings.name]!(settings));
  }
}
