import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/historial_mediciones_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/last_medical_information_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/medical_information_complete_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/historial_mediciones_state.dart';
import 'package:smartbeat_frontend/home/bloc/states/last_medical_information_state.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_complete_state.dart';
import 'package:smartbeat_frontend/home/forms/info_medica_form.dart';
import 'package:smartbeat_frontend/home/models/medical_information.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/informacion_medica_dialog.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/lista_historial_mediciones.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/stacked_bar_chart.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/components/medical_information_body.dart';
import 'package:smartbeat_frontend/home/screens/diagnostico/diagnostic_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/components/tab_buttons.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_constants.dart';
import 'package:smartbeat_frontend/shared/utils/utils.dart';

enum TypeFilter { Todos, Hoy, Diagnostico }

class ConsultaMedicaScreen extends StatefulWidget {
  static String route = 'consulta_medica_screen';
  final ConsultaMedicaScreenArgs args;

  const ConsultaMedicaScreen({super.key, required this.args});

  @override
  State<ConsultaMedicaScreen> createState() => _ConsultaMedicaScreenState();
}

class _ConsultaMedicaScreenState extends State<ConsultaMedicaScreen> {
  late int medicalRecordId;
  List<String> typeFilterOptions =
      TypeFilter.values.map((type) => type.name).toList();
  TypeFilter selectedType = TypeFilter.Todos;
  int selectedTypeIndex = 0;

  Future<void> setInformacionMedicaForm(
      MedicalInformation medicalInformation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    InfoMedicaForm form = InfoMedicaForm(
        height: double.parse(medicalInformation.height),
        weight: double.parse(medicalInformation.weight),
        smoke: medicalInformation.smoke,
        sedentary: medicalInformation.sedentary,
        alcohol: medicalInformation.alcohol);
    Map<String, dynamic>? infoMedicaForm = form.rawValue;
    await prefs.setString(AppConstants.keyInfoApp, jsonEncode(infoMedicaForm));
  }

  Future<void> setPatologias(List<String> patologias) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic>? patologiasMap = {'patologias': patologias};
    await prefs.setString(
        AppConstants.keyPatologias, jsonEncode(patologiasMap));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MedicalInformationCompleteCubit(),
        ),
        BlocProvider(
          create: (context) => HistorialMedicionesCubit()
            ..fetch(
              widget.args.consultaMedicaId,
              TypeFilter.Todos,
            ),
        ),
        BlocProvider(
          create: (context) => LastMedicalInformationCubit()
            ..fetch(
              widget.args.consultaMedicaId,
            ),
        )
      ],
      child: BlocConsumer<MedicalInformationCompleteCubit,
          MedicalInformationCompleteState>(
        listener: (contextMedicalInformation, stateMedicalInformation) {
          if (stateMedicalInformation is MedicalInformationCompleteSuccess) {
            showDialog(
              context: context,
              builder: (contextMedicalInformation) => CustomDialog(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      MedicalInformationBody(
                        medicalInformationComplete:
                            stateMedicalInformation.medicalInformationComplete,
                        showSectionPresionArterial: false,
                        doctorPhone: widget.args.doctorPhone,
                      ),
                      Spacer(),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              contextMedicalInformation,
                              DiagnosticScreen.route,
                              arguments: DiagnosticScreenArgs(
                                medicalRecordId: medicalRecordId,
                              ),
                            );
                          },
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Ver diagnostico'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Utils.redirectToWsp(widget.args.doctorPhone,
                                contextMedicalInformation);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.whatsapp,
                                color: AppColors.primary,
                              ),
                              SizedBox(width: 5.0),
                              Text('Contactar'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            );
          }

          if (stateMedicalInformation is MedicalInformationCompleteFailure) {
            Utils.showSnackBar(context,
                'Se presentó un error, intentelo de nuevo en unos minutos.');
          }
        },
        builder: (contextMedicalInformation, stateMedicalInformation) {
          final cubit = BlocProvider.of<MedicalInformationCompleteCubit>(
              contextMedicalInformation);

          return BlocConsumer<HistorialMedicionesCubit,
              HistorialMedicionesState>(
            listener: (contextHistorialMediciones, stateHistorialMediciones) {
              if (stateHistorialMediciones is HistorialMedicionesFailure) {
                Utils.showSnackBar(context,
                    'Se presentó un error, intentelo de nuevo en unos minutos.');
              }
            },
            builder: (contextHistorialMediciones, stateHistorialMediciones) {
              final cubitHistorialMediciones =
                  BlocProvider.of<HistorialMedicionesCubit>(
                      contextHistorialMediciones);

              return BlocConsumer<LastMedicalInformationCubit,
                  LastMedicalInformationState>(listener: (context, state) {
                if (state is LastMedicalInformationSuccess) {
                  setInformacionMedicaForm(
                      state.lastMedicalInformation.lastMedicalInformation);
                  setPatologias(state.lastMedicalInformation.patologias);
                }
              }, builder: (context, state) {
                return CustomScaffold(
                  useAppBar: true,
                  backgroundColor: Colors.white,
                  body: Loading(
                    isLoading: stateMedicalInformation
                            is MedicalInformationCompleteLoading ||
                        stateHistorialMediciones
                            is HistorialMedicionesLoading ||
                        state is LastMedicalInformationLoading,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 15.0),
                            if (stateHistorialMediciones
                                is HistorialMedicionesSuccess) ...[
                              StackedBarChart(
                                numberOfBars: cubitHistorialMediciones
                                    .listConsultaMedica.length,
                                progressValues: cubitHistorialMediciones
                                    .listConsultaMedica
                                    .map((medicion) => medicion.ppg.ppgBar)
                                    .toList(),
                                dates: cubitHistorialMediciones
                                    .listConsultaMedica
                                    .map((medicion) => Utils.formatearFecha(
                                        medicion.ppg.ppgDate))
                                    .toList(),
                                clasificationValues: cubitHistorialMediciones
                                    .listConsultaMedica
                                    .map((medicion) =>
                                        medicion.ppg.ppgClasification)
                                    .toList(),
                              ),
                              const SizedBox(height: 20.0),
                            ],
                            Row(
                              children: [
                                Text(
                                  'Historial Medico',
                                  style: textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: contextMedicalInformation,
                                      builder: (context) =>
                                          InformacionMedicaDialog(
                                        consultaMedicaId:
                                            widget.args.consultaMedicaId,
                                        lastMedicalRecordId:
                                            widget.args.lastMedicalRecordId,
                                      ),
                                    );
                                  },
                                  child: Text('+ Presion'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            TabButtons(
                              options: typeFilterOptions,
                              onOptionSelected: (index) {
                                selectedTypeIndex = index;
                                selectedType = TypeFilter.values[index];
                                cubitHistorialMediciones.fetch(
                                    widget.args.consultaMedicaId, selectedType);
                                setState(() {});
                              },
                              selectedIndex: selectedTypeIndex,
                            ),
                            const SizedBox(height: 15.0),
                            if (stateHistorialMediciones
                                is HistorialMedicionesSuccess)
                              HistorialMedicionesList(
                                mediciones:
                                    cubitHistorialMediciones.listConsultaMedica,
                                onTapRowHistorialMedicion: (rowMedicion) {
                                  cubit.fetch(
                                      rowMedicion.ppg.medicalInformationId);
                                  medicalRecordId = rowMedicion.medicalRecordId;
                                },
                              ),
                            if (stateHistorialMediciones
                                is HistorialMedicionesFailure)
                              Center(
                                child: Text(selectedType == TypeFilter.Hoy
                                    ? 'No se ha elaborado una presión arterial hoy'
                                    : 'No se ha recibido ningún Diagnóstico'),
                              ),
                            const SizedBox(height: 15.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}

class ConsultaMedicaScreenArgs {
  final int consultaMedicaId;
  final int lastMedicalRecordId;
  final String doctorPhone;

  const ConsultaMedicaScreenArgs({
    required this.consultaMedicaId,
    required this.lastMedicalRecordId,
    required this.doctorPhone,
  });
}
