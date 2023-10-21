import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/historial_mediciones_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/medical_information_complete_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/historial_mediciones_state.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_complete_state.dart';
import 'package:smartbeat_frontend/home/pages/chatbot/chatbot_screen.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/lista_historial_mediciones.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/stacked_bar_chart.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/components/medical_information_body.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/consulta_medica_screen.dart';
import 'package:smartbeat_frontend/home/screens/diagnostico/diagnostic_screen.dart';
import 'package:smartbeat_frontend/home/screens/registrar_diagnostico_screen.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/components/tab_buttons.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/utils.dart';

class MedicalInformationCompleteScreen extends StatefulWidget {
  static String route = 'medical_information_complete_screen';
  final MedicalInformationCompleteScreenArgs args;

  const MedicalInformationCompleteScreen({
    super.key,
    required this.args,
  });

  @override
  State<MedicalInformationCompleteScreen> createState() =>
      _MedicalInformationCompleteScreenState();
}

class _MedicalInformationCompleteScreenState
    extends State<MedicalInformationCompleteScreen> {
  late int medicalRecordId;
  late int medicalInformationId;
  List<String> typeFilterOptions =
      TypeFilter.values.map((type) => type.name).toList();
  TypeFilter selectedType = TypeFilter.Todos;
  int selectedTypeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final infoAppCubit = BlocProvider.of<InfoAppCubit>(context);
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
        )
      ],
      child: BlocConsumer<MedicalInformationCompleteCubit,
          MedicalInformationCompleteState>(
        listener: (contextMedicalInformation, stateMedicalInformation) {
          if (stateMedicalInformation is MedicalInformationCompleteSuccess) {
            showDialog(
              context: contextMedicalInformation,
              builder: (contextMedicalInformation) => CustomDialog(
                size: DialogHeightSize.large,
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MedicalInformationBody(
                          medicalInformationComplete: stateMedicalInformation
                              .medicalInformationComplete,
                          doctorPhone: widget.args.doctorPhone,
                        ),
                        if (stateMedicalInformation
                                .medicalInformationComplete.diagnosticExist ==
                            'Realizado')
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                contextMedicalInformation,
                                DiagnosticScreen.route,
                                arguments: DiagnosticScreenArgs(
                                  medicalRecordId: medicalRecordId,
                                ),
                              );
                            },
                            child: const Text('Ver diagnostico'),
                          ),
                        const SizedBox(height: 5.0),
                        if (stateMedicalInformation
                                .medicalInformationComplete.diagnosticExist ==
                            'Por realizar') ...[
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                contextMedicalInformation,
                                ChatBotScreen.route,
                                arguments: ChatBotScreenArgs(
                                  medicalInformationId: medicalInformationId,
                                  doctorLastName:
                                      infoAppCubit.infoApp.dataUser!.lastName!,
                                  lastMedicalRecordId: medicalRecordId,
                                ),
                              );
                            },
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Sugerencias',
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                contextMedicalInformation,
                                RegistrarDiagnosticoScreen.route,
                                arguments: RegistrarDiagnosticoScreenArgs(
                                  idMedicalRecord: medicalRecordId,
                                ),
                              );
                            },
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Realizar diagnostico',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                        OutlinedButton(
                          onPressed: () {
                            Utils.redirectToWsp(widget.args.doctorPhone,
                                contextMedicalInformation);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.whatsapp,
                                color: AppColors.secondary,
                              ),
                              SizedBox(width: 10.0),
                              Text('Contactar'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
        builder: (contextMedicalInformation, stateMedicalInformation) {
          final cubit = BlocProvider.of<MedicalInformationCompleteCubit>(
              contextMedicalInformation);
          return BlocConsumer<HistorialMedicionesCubit,
              HistorialMedicionesState>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubitHistorialMediciones =
                  BlocProvider.of<HistorialMedicionesCubit>(
                      contextMedicalInformation);

              return CustomScaffold(
                useAppBar: true,
                backgroundColor: Colors.white,
                body: Loading(
                  isLoading: stateMedicalInformation
                          is MedicalInformationCompleteLoading ||
                      state is HistorialMedicionesLoading,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state is HistorialMedicionesSuccess) ...[
                            StackedBarChart(
                              numberOfBars: cubitHistorialMediciones
                                  .listConsultaMedica.length,
                              progressValues: cubitHistorialMediciones
                                  .listConsultaMedica
                                  .map((medicion) => medicion.ppg.ppgBar)
                                  .toList(),
                              dates: cubitHistorialMediciones.listConsultaMedica
                                  .map((medicion) => Utils.formatearFecha(
                                      medicion.ppg.ppgDate))
                                  .toList(),
                              clasificationValues: cubitHistorialMediciones
                                  .listConsultaMedica
                                  .map((medicion) =>
                                      medicion.ppg.ppgClasification)
                                  .toList(),
                            ),
                            const SizedBox(height: 15.0)
                          ],
                          Text(
                            'Historial Medico',
                            style: textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
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
                          if (state is HistorialMedicionesSuccess) ...[
                            const SizedBox(height: 15.0),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: HistorialMedicionesList(
                                mediciones:
                                    cubitHistorialMediciones.listConsultaMedica,
                                onTapRowHistorialMedicion: (rowMedicion) {
                                  cubit.fetch(
                                      rowMedicion.ppg.medicalInformationId);
                                  medicalRecordId = rowMedicion.medicalRecordId;
                                  medicalInformationId =
                                      rowMedicion.ppg.medicalInformationId;
                                },
                              ),
                            ),
                          ],
                          const SizedBox(height: 15.0),
                          if (state is HistorialMedicionesFailure)
                            Center(
                              child: Text(selectedType == TypeFilter.Hoy
                                  ? 'No se ha elaborado una presión arterial hoy'
                                  : 'No se ha recibido ningún Diagnóstico'),
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

class MedicalInformationCompleteScreenArgs {
  final String doctorPhone;
  final int consultaMedicaId;

  const MedicalInformationCompleteScreenArgs({
    required this.doctorPhone,
    required this.consultaMedicaId,
  });
}
