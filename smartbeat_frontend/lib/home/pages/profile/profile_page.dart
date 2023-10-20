import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/consulta_medica_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/consulta_medica_state.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/header_section.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/medico_detail_section.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/paciente_detail_section.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final infoAppCubit = BlocProvider.of<InfoAppCubit>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConsultaMedicaCubit()
            ..fetch(infoAppCubit.infoApp.typeUser!,
                infoAppCubit.infoApp.dataUser!.id!),
        ),
      ],
      child: BlocConsumer<ConsultaMedicaCubit, ConsultaMedicaState>(
        listener: (contextConsultaMedica, stateConsultaMedica) {
          if (stateConsultaMedica is ConsultaMedicaSuccess &&
              stateConsultaMedica.listConsultaMedica.isEmpty) {
            Navigator.pushNamed(contextConsultaMedica, HomeNavBarScreen.route,
                arguments: const HomeNavBarScreenArgs(indexPage: 1));
          }
          if (stateConsultaMedica is ConsultaMedicaFailure) {
            Navigator.pushNamed(contextConsultaMedica, HomeNavBarScreen.route,
                arguments: const HomeNavBarScreenArgs(indexPage: 1));
          }
        },
        builder: (contextConsultaMedica, stateConsultaMedica) {
          final cubitConsultaMedica =
              BlocProvider.of<ConsultaMedicaCubit>(contextConsultaMedica);

          return CustomScaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.secondary,
              onPressed: () {
                cubitConsultaMedica.fetch(infoAppCubit.infoApp.typeUser!,
                    infoAppCubit.infoApp.dataUser!.id!);
              },
              child: const Icon(Icons.update),
            ),
            useAppBar: true,
            body: Loading(
              isLoading: stateConsultaMedica is ConsultaMedicaLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30.0),
                      HeaderSection(
                        pathImg: Utils.getImageProfile(
                            infoAppCubit.infoApp.dataUser!.gender!,
                            infoAppCubit.infoApp.typeUser!),
                        title:
                            "${infoAppCubit.infoApp.dataUser!.name!} ${infoAppCubit.infoApp.dataUser!.lastName!}",
                      ),
                      if (infoAppCubit.infoApp.typeUser == TypeUser.patient)
                        PacienteDetailSection(
                          listConsultaMedica:
                              cubitConsultaMedica.listConsultaMedica,
                        ),
                      if (infoAppCubit.infoApp.typeUser == TypeUser.doctor)
                        MedicoDetailSection(
                          listConsultaMedica:
                              cubitConsultaMedica.listConsultaMedica,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
