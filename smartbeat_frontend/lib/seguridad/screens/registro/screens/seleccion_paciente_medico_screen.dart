import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/seguridad/forms/registro_inicial_form.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/components/type_user_card.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_gradient_background.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class SeleccionPacienteMedicoScreen extends StatelessWidget {
  static String route = 'seleccion_paciente_medico_screen';
  final SeleccionPacienteMedicoArgs args;

  const SeleccionPacienteMedicoScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        CustomGradientBackground(
          colors: [
            AppColors.primary.withOpacity(0.01),
            AppColors.primary.withOpacity(0.30),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
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
                  arguments: DatosPersonalesScreenArgs(
                    typeUser: TypeUser.doctor,
                    registroInicialForm: args.registroInicialForm,
                  ),
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
                  arguments: DatosPersonalesScreenArgs(
                    typeUser: TypeUser.patient,
                    registroInicialForm: args.registroInicialForm,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class SeleccionPacienteMedicoArgs {
  final RegistroInicialForm registroInicialForm;

  const SeleccionPacienteMedicoArgs(this.registroInicialForm);
}
