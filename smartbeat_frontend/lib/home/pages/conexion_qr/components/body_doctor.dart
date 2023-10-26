import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/register_consulta_medica_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/register_consulta_medica_state.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/shared/components/custom_shadow_container.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:smartbeat_frontend/shared/utils/app_images.dart';
import 'package:smartbeat_frontend/shared/utils/utils.dart';

class BodyDoctor extends StatefulWidget {
  const BodyDoctor({super.key});

  @override
  State<BodyDoctor> createState() => _BodyDoctorState();
}

class _BodyDoctorState extends State<BodyDoctor> {
  int? newIdPattient;

  @override
  Widget build(BuildContext context) {
    final infoApp = BlocProvider.of<InfoAppCubit>(context).infoApp;

    return BlocProvider(
      create: (context) => RegisterConsultaMedicaCubit(),
      child: BlocConsumer<RegisterConsultaMedicaCubit,
          RegisterConsultaMedicaState>(listener: (context, state) {
        if (state is RegisterConsultaMedicaSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeNavBarScreen.route,
            (_) => false,
            arguments: const HomeNavBarScreenArgs(indexPage: 0),
          );
        }
        if (state is RegisterConsultaMedicaFailure) {
          Utils.showSnackBar(context,
              'Ocurrio un error, por favor intente de nuevo en unos minutos');
        }
      }, builder: (context, state) {
        final cubit = BlocProvider.of<RegisterConsultaMedicaCubit>(context);
        if (state is RegisterConsultaMedicaLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Text(
                'Conecta con tus pacientes de forma rapida y segura.',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Text(
                'Simplifica la gestión de tus pacientes. Escanea el QR para agregar fácilmente perfiles individuales, permitiendo un seguimiento más efectivo y personalizado de su salud cardiovascular. Conecta con tus pacientes de forma rápida y segura para brindar un cuidado óptimo.',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(color: AppColors.secondary, letterSpacing: 1.0),
              ),
              const Spacer(),
              if (newIdPattient == null)
                Column(
                  children: [
                    CustomShadowContainer(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Image.asset(
                              AppImages.qrConexion,
                              height: 150.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: _scan, child: const Text('Scan QR'))
                  ],
                ),
              if (newIdPattient != null)
                ElevatedButton(
                  onPressed: () {
                    cubit.registrarPresionPpg(
                        newIdPattient!, infoApp.dataUser!.id!);
                  },
                  child: Text('Crear consulta medica'),
                ),
              const Spacer(),
            ],
          ),
        );
      }),
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    String? barcode = await scanner.scan();
    if (barcode == null) {
      newIdPattient = null;
    } else {
      newIdPattient = int.tryParse(barcode);
      setState(() {});
    }
  }
}
