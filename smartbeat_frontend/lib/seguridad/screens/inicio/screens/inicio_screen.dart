import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/screens/login_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/registro_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class InicioScreen extends StatelessWidget {
  static String route = 'inicio_screen';

  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Image.asset(
            AppImages.fondoInicio,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 200.0,
            left: 0,
            right: 0,
            bottom: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.01),
                    Colors.white.withOpacity(0.85),
                    Colors.white.withOpacity(0.90),
                    Colors.white.withOpacity(0.95),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 15.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.splashIcon,
                      height: 80.0,
                    ),
                    const SizedBox(width: 20.0),
                    Image.asset(
                      AppImages.splashText,
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.route);
                    },
                    child: const Text('Iniciar Sesion'),
                  ),
                ),
                const SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RegistroScreen.route);
                    },
                    child: Text('Registrate'),
                  ),
                ),
                const SizedBox(height: 30.0),
                TextButton(
                    onPressed: () {}, child: Text('Continue como invitado')),
                const SizedBox(height: 15.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
