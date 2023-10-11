import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/pages/conexion_qr/components/body_doctor.dart';
import 'package:smartbeat_frontend/home/pages/conexion_qr/components/body_patient.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/shared/components/custom_gradient_background.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class ConexionQrPage extends StatefulWidget {
  const ConexionQrPage({super.key});

  @override
  State<ConexionQrPage> createState() => _ConexionQrPageState();
}

class _ConexionQrPageState extends State<ConexionQrPage> {
  @override
  Widget build(BuildContext context) {
    final infoApp = BlocProvider.of<InfoAppCubit>(context).infoApp;

    return CustomScaffold(
      useAppBar: true,
      backgroundColorAppBar: Colors.white,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomGradientBackground(
            colors: [
              AppColors.primary.withOpacity(0.01),
              AppColors.primary.withOpacity(0.30),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          if (infoApp.isDoctor!) BodyDoctor(),
          if (!infoApp.isDoctor!) BodyPatient()
        ],
      ),
    );
  }
}
