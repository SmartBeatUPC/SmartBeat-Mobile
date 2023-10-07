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
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final infoAppCubit = BlocProvider.of<InfoAppCubit>(context);

    return CustomScaffold(
      backgroundColor: Colors.white,
      useAppBar: true,
      body: BlocProvider(
        create: (context) => ConsultaMedicaCubit()
          ..fetch(infoAppCubit.infoApp.typeUser!,
              infoAppCubit.infoApp.dataUser!.id!),
        child: BlocConsumer<ConsultaMedicaCubit, ConsultaMedicaState>(
            listener: (context, state) {
          if (state is ConsultaMedicaSuccess &&
              state.listConsultaMedica.isEmpty) {
            Navigator.pushNamed(context, HomeNavBarScreen.route,
                arguments: const HomeNavBarScreenArgs(indexPage: 2));
          }
        }, builder: (context, state) {
          final cubit = BlocProvider.of<ConsultaMedicaCubit>(context);

          return Loading(
            isLoading: state is ConsultaMedicaLoading,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 30.0),
                    HeaderSection(
                        pathImg:
                            infoAppCubit.infoApp.typeUser == TypeUser.patient
                                ? AppImages.paciente2
                                : AppImages.medico,
                        title: infoAppCubit.infoApp.typeUser == TypeUser.patient
                            ? 'Juan López'
                            : 'Dra. Jésica Girón'),
                    if (infoAppCubit.infoApp.typeUser == TypeUser.patient)
                      PacienteDetailSection(
                        listConsultaMedica: cubit.listConsultaMedica,
                      ),
                    if (infoAppCubit.infoApp.typeUser == TypeUser.doctor)
                      MedicoDetailSection(),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
