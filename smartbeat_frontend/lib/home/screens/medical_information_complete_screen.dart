import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/medical_information_complete_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_complete_state.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/lista_historial_mediciones.dart';
import 'package:smartbeat_frontend/home/screens/consulta_medica/components/medical_information_body.dart';
import 'package:smartbeat_frontend/home/screens/registrar_diagnostico_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';

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
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15.0),
                      Text(
                        'Historial Medico',
                        style: textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15.0),
                      HistorialMedicionesList(
                        mediciones: widget.args.mediciones,
                        onTapRowHistorialMedicion: (rowMedicion) {
                          cubit.fetch(rowMedicion.ppg.medicalInformationId);
                          medicalRecordId = rowMedicion.medicalRecordId;
                        },
                      ),
                      if (state is MedicalInformationCompleteSuccess) ...[
                        const SizedBox(height: 10.0),
                        MedicalInformationBody(
                            medicalInformationComplete:
                                state.medicalInformationComplete),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RegistrarDiagnosticoScreen.route,
                                    arguments: RegistrarDiagnosticoScreenArgs(
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
                            const SizedBox(width: 20.0),
                            Flexible(
                              child: OutlinedButton(
                                onPressed: () {},
                                child: const Text('Sugerencias chatgpt',
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                      ]
                    ],
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

  const MedicalInformationCompleteScreenArgs({
    required this.mediciones,
  });
}
