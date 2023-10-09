import 'package:flutter/cupertino.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/analisis_medico_screen.dart';
import 'package:smartbeat_frontend/home/pages/chatbot/chatbot_screen.dart';
import 'package:smartbeat_frontend/home/screens/agregar_patologias_screen.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
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
    ChatBotScreen.route: (settings) {
      final args = settings.arguments.castOr<ChatBotScreenArgs>()!;
      return ChatBotScreen(args: args);
    },
    AgregarPatologiasScreen.route: (settings) {
      final args = settings.arguments.castOr<AgregarPatologiasScreenArgs>()!;
      return AgregarPatologiasScreen(args: args);
    },
    HomeNavBarScreen.route: (settings) {
      final args = settings.arguments.castOr<HomeNavBarScreenArgs>()!;
      return HomeNavBarScreen(args: args);
    },
    AnalisisMedicoScreen.route: (settings) {
      final args = settings.arguments.castOr<AnalisisMedicoScreenArgs>()!;
      return AnalisisMedicoScreen(args: args);
    },
    SeleccionPacienteMedicoScreen.route: (settings) {
      final args = settings.arguments.castOr<SeleccionPacienteMedicoArgs>()!;
      return SeleccionPacienteMedicoScreen(args: args);
    },
    DatosPersonalesScreen.route: (settings) {
      final args = settings.arguments.castOr<DatosPersonalesScreenArgs>()!;
      return DatosPersonalesScreen(args: args);
    },
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (_) => routes[settings.name]!(settings));
  }
}
