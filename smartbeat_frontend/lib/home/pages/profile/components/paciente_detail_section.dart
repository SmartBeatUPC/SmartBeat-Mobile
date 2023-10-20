import 'package:flutter/material.dart';
import 'informacion_medica_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/historial_mediciones_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/historial_mediciones_state.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/consulta_medica_screen.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/extensions/string_extension.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class PacienteDetailSection extends StatefulWidget {
  final List<ConsultaMedica> listConsultaMedica;

  const PacienteDetailSection({
    super.key,
    required this.listConsultaMedica,
  });

  @override
  State<PacienteDetailSection> createState() => _PacienteDetailSectionState();
}

class _PacienteDetailSectionState extends State<PacienteDetailSection> {
  late int consultaMedicaId;
  late int lastMedicalRecordId;
  late int medicalInformationId;
  late String doctorPhone;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final infoAppCubit = BlocProvider.of<InfoAppCubit>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  '${infoAppCubit.infoApp.dataUser!.age!} Años',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.acentText, fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 2,
                child: Text(infoAppCubit.infoApp.email ?? '',
                    textAlign: TextAlign.center),
              ),
              Flexible(
                flex: 1,
                child: Text('+51${infoAppCubit.infoApp.dataUser!.phone!}',
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        BlocProvider(
          create: (context) => HistorialMedicionesCubit(),
          child:
              BlocConsumer<HistorialMedicionesCubit, HistorialMedicionesState>(
            listener: (context, state) {
              if (state is HistorialMedicionesSuccess) {
                Navigator.pushNamed(
                  context,
                  ConsultaMedicaScreen.route,
                  arguments: ConsultaMedicaScreenArgs(
                      consultaMedicaId: consultaMedicaId,
                      lastMedicalRecordId: lastMedicalRecordId,
                      doctorPhone: doctorPhone),
                );
              }

              if (state is HistorialMedicionesFailure) {
                showDialog(
                  context: context,
                  builder: (context) => InformacionMedicaDialog(
                    consultaMedicaId: consultaMedicaId,
                    lastMedicalRecordId: lastMedicalRecordId,
                  ),
                );
              }
            },
            builder: (context, state) {
              final cubit = BlocProvider.of<HistorialMedicionesCubit>(context);

              if (state is HistorialMedicionesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Consultas Medicas',
                        style: textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      OutlinedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  size: DialogHeightSize.extraSmall,
                                  hasClose: false,
                                  body: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Para iniciar una consulta \nmedica, debes presentar\n tu QR a tu medico.',
                                          textAlign: TextAlign.center,
                                          style: textTheme.titleLarge?.copyWith(
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(height: 15.0),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  HomeNavBarScreen.route,
                                                  arguments:
                                                      const HomeNavBarScreenArgs(
                                                          indexPage: 1));
                                            },
                                            child: const Text('Ver QR'))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text('+ consulta'))
                    ],
                  ),
                  Column(
                    children: widget.listConsultaMedica.map((consulta) {
                      return Card(
                        elevation: 3,
                        shadowColor: Colors.black,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onTap: () {
                            lastMedicalRecordId = consulta.lastMedicalRecordId;
                            doctorPhone = consulta.doctorData.phone!;
                            consultaMedicaId = consulta.consultation.id;
                            cubit.fetch(consultaMedicaId, TypeFilter.Todos);
                            setState(() {});
                          },
                          title: RichText(
                            text: TextSpan(
                              text: 'Doctor: ',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${consulta.doctorData.name!} ${consulta.doctorData.lastName!}'
                                          .toTitlecase(),
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          subtitle: Text(
                            consulta.lastRecordDate,
                            textAlign: TextAlign.end,
                            style: textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
