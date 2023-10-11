import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/medical_information_complete_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_complete_state.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/informacion_medica_dialog.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/lista_historial_mediciones.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/components/medical_information_body.dart';
import 'package:smartbeat_frontend/home/screens/diagnostico/diagnostic_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';

class ConsultaMedicaScreen extends StatefulWidget {
  static String route = 'consulta_medica_screen';
  final ConsultaMedicaScreenArgs args;

  const ConsultaMedicaScreen({super.key, required this.args});

  @override
  State<ConsultaMedicaScreen> createState() => _ConsultaMedicaScreenState();
}

class _ConsultaMedicaScreenState extends State<ConsultaMedicaScreen> {
  late int medicalRecordId;

  @override
  Widget build(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15.0),
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
                                context: context,
                                builder: (context) => InformacionMedicaDialog(
                                    consultaMedicaId: widget.args.consultaMedicaId),
                              );
                            },
                            child: Text('+ Presion'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      HistorialMedicionesList(
                        mediciones: widget.args.listHistorialMedicion,
                        onTapRowHistorialMedicion: (rowMedicion) {
                          cubit.fetch(rowMedicion.ppg.medicalInformationId);
                          medicalRecordId = rowMedicion.medicalRecordId;
                        },
                      ),
                      const SizedBox(height: 15.0),
                      if (state is MedicalInformationCompleteSuccess) ...[
                        MedicalInformationBody(
                          medicalInformationComplete:
                              state.medicalInformationComplete,
                          showSectionPresionArterial: false,
                        ),
                        SizedBox(
                          width: double.infinity,
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
                        )
                      ],
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

class ConsultaMedicaScreenArgs {
  final List<HistorialMedicion> listHistorialMedicion;
  final int consultaMedicaId;

  const ConsultaMedicaScreenArgs({
    required this.listHistorialMedicion,
    required this.consultaMedicaId,
  });
}
