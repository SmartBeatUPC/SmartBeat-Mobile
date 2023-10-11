import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/consulta_medica_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/medical_information_complete_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/consulta_medica_state.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_complete_state.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/header_section.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/medico_detail_section.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/paciente_detail_section.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/home/screens/medical_information_complete_screen.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/extensions/string_extension.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';
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
        BlocProvider(
          create: (context) => MedicalInformationCompleteCubit(),
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

          return BlocConsumer<MedicalInformationCompleteCubit,
              MedicalInformationCompleteState>(
            listener: (contextMedicalComplete, stateMedicalComplete) {
              if (stateMedicalComplete is MedicalInformationCompleteFailure) {
                Utils.showSnackBar(context,
                    'El usuario aun no completó su informacion medica.');
              }

              if (stateMedicalComplete is MedicalInformationCompleteSuccess) {
                Navigator.pushNamed(
                  context,
                  MedicalInformationCompleteScreen.route,
                  arguments: MedicalInformationCompleteScreenArgs(
                    medicalInformationComplete:
                        stateMedicalComplete.medicalInformationComplete,
                  ),
                );
              }
            },
            builder: (contextMedicalComplete, stateMedicalComplete) {
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
                  isLoading: stateConsultaMedica is ConsultaMedicaLoading ||
                      stateMedicalComplete is MedicalInformationCompleteLoading,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 30.0),
                          HeaderSection(
                            pathImg: infoAppCubit.infoApp.typeUser ==
                                    TypeUser.patient
                                ? AppImages.paciente2
                                : AppImages.medico,
                            title:
                                "${infoAppCubit.infoApp.dataUser!.name!} ${infoAppCubit.infoApp.dataUser!.lastName!}"
                                    .toTitlecase(),
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
          );
        },
      ),
    );
  }
}
