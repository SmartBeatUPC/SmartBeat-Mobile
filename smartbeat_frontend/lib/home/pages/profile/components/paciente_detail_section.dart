import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/historial_mediciones_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/historial_mediciones_state.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/consulta_medica_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/extensions/string_extension.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

import 'informacion_medica_dialog.dart';

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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                  '58 Años',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.acentText, fontWeight: FontWeight.bold),
                ),
              ),
              const Flexible(
                flex: 2,
                child: Text('jlopez@gmail.com', textAlign: TextAlign.center),
              ),
              const Flexible(
                flex: 1,
                child: Text('+51985748248', textAlign: TextAlign.center),
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
                    listHistorialMedicion: state.listHistorialMedicion,
                    consultaMedicaId: consultaMedicaId
                  ),
                );
              }

              if (state is HistorialMedicionesFailure) {
                showDialog(
                  context: context,
                  builder: (context) => InformacionMedicaDialog(
                      consultaMedicaId: consultaMedicaId),
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
                                return const CustomDialog(
                                  body: Center(
                                    child: Text(
                                      'Para iniciar una consulta medica, debes presentar tu QR a tu medico.',
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
                            consultaMedicaId = consulta.consultation.id;
                            cubit.fetch(consultaMedicaId);
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
