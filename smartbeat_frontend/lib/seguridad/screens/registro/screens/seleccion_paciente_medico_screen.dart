import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/components/type_user_card.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class SeleccionPacienteMedicoScreen extends StatelessWidget {
  static String route = 'seleccion_paciente_medico_screen';

  const SeleccionPacienteMedicoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
          top: 500.0,
          left: 0,
          right: 0,
          bottom: 0.0,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withOpacity(0.01),
                  AppColors.primary.withOpacity(0.30),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TypeUserCard(
                pathImage: AppImages.medico,
                label: "Soy médico",
                textBoxColor: AppColors.primary,
                onTap: () => Navigator.pushNamed(
                  context,
                  DatosPersonalesScreen.route,
                  arguments: const DatosPersonalesPacienteScreenArgs(
                      typeUser: TypeUser.Medico),
                ),
              ),
              const SizedBox(height: 10.0),
              TypeUserCard(
                pathImage: AppImages.paciente,
                label: "Soy paciente",
                textBoxColor: AppColors.secondary,
                onTap: () => Navigator.pushNamed(
                  context,
                  DatosPersonalesScreen.route,
                  arguments: const DatosPersonalesPacienteScreenArgs(
                      typeUser: TypeUser.Paciente),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
