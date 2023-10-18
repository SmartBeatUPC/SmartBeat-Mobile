import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/medical_information_complete_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_complete_state.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/home/pages/chatbot/chatbot_screen.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/lista_historial_mediciones.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/stacked_bar_chart.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/components/medical_information_body.dart';
import 'package:smartbeat_frontend/home/screens/diagnostico/diagnostic_screen.dart';
import 'package:smartbeat_frontend/home/screens/registrar_diagnostico_screen.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
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

  @override
  Widget build(BuildContext context) {
    final infoAppCubit = BlocProvider.of<InfoAppCubit>(context);
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => MedicalInformationCompleteCubit(),
      child: BlocConsumer<MedicalInformationCompleteCubit,
              MedicalInformationCompleteState>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit =
                BlocProvider.of<MedicalInformationCompleteCubit>(context);
            return CustomScaffold(
              useAppBar: true,
              backgroundColor: Colors.white,
              body: Loading(
                isLoading: state is MedicalInformationCompleteLoading,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StackedBarChart(
                          numberOfBars: widget.args.mediciones.length,
                          progressValues: widget.args.mediciones
                              .map((medicion) => medicion.ppg.ppgBar)
                              .toList(),
                          dates: widget.args.mediciones
                              .map((medicion) =>
                                  Utils.formatearFecha(medicion.ppg.ppgDate))
                              .toList(),
                          clasificationValues: widget.args.mediciones
                              .map((medicion) => medicion.ppg.ppgClasification)
                              .toList(),
                        ),
                        const SizedBox(height: 15.0),
                        Text(
                          'Historial Medico',
                          style: textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15.0),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: HistorialMedicionesList(
                            mediciones: widget.args.mediciones,
                            onTapRowHistorialMedicion: (rowMedicion) {
                              cubit.fetch(rowMedicion.ppg.medicalInformationId);
                              medicalRecordId = rowMedicion.medicalRecordId;
                              medicalInformationId =
                                  rowMedicion.ppg.medicalInformationId;
                            },
                          ),
                        ),
                        if (state is MedicalInformationCompleteSuccess) ...[
                          MedicalInformationBody(
                            medicalInformationComplete:
                                state.medicalInformationComplete,
                            doctorPhone: widget.args.doctorPhone,
                          ),
                          Row(
                            children: [
                              if (state.medicalInformationComplete
                                      .diagnosticExist ==
                                  'Por realizar') ...[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        RegistrarDiagnosticoScreen.route,
                                        arguments:
                                            RegistrarDiagnosticoScreenArgs(
                                          idMedicalRecord: medicalRecordId,
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Realizar diagnostico',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                              if (state.medicalInformationComplete
                                      .diagnosticExist ==
                                  'Realizado') ...[
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        DiagnosticScreen.route,
                                        arguments: DiagnosticScreenArgs(
                                          medicalRecordId: medicalRecordId,
                                        ),
                                      );
                                    },
                                    child: const Text('Ver diagnostico'),
                                  ),
                                ),
                              ]
                            ],
                          ),
                          const SizedBox(height: 20.0),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class MedicalInformationCompleteScreenArgs {
  final List<HistorialMedicion> mediciones;
  final String doctorPhone;

  const MedicalInformationCompleteScreenArgs({
    required this.mediciones,
    required this.doctorPhone,
  });
}
