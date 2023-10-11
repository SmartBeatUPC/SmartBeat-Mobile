import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/medical_information_complete.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/medida_presion_info.dart';
import 'package:smartbeat_frontend/home/screens/registrar_diagnostico_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/custom_shadow_container.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class MedicalInformationCompleteScreen extends StatelessWidget {
  static String route = 'medical_information_complete_screen';
  final MedicalInformationCompleteScreenArgs args;

  const MedicalInformationCompleteScreen({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    MedidaPresionPaciente medidaPresionPaciente = MedidaPresionPaciente(
      sys: args.medicalInformationComplete.bloodPressureSistolic,
      dia: args.medicalInformationComplete.bloodPressureDiastolic,
      bpm: args.medicalInformationComplete.bmi,
    );
    return CustomScaffold(
      useAppBar: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            Text(
              'Informacion Medica',
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
              child: CustomShadowContainer(
                color: AppColors.primary.withOpacity(0.25),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                borderRadius: BorderRadius.circular(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Altura:',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w400)),
                        const Spacer(),
                        Text(args.medicalInformationComplete.height,
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Peso:',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w400)),
                        const Spacer(),
                        Text(args.medicalInformationComplete.weight,
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('¿ Fuma tabaco ?',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w400)),
                        const Spacer(),
                        Text(
                            args.medicalInformationComplete.smoke ? 'Si' : 'No',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('¿ Toma alcohool ?',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w400)),
                        const Spacer(),
                        Text(
                            args.medicalInformationComplete.alcohol
                                ? 'Si'
                                : 'No',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('¿ Realiza ejercicio ?',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w400)),
                        const Spacer(),
                        Text(
                            args.medicalInformationComplete.sedentary
                                ? 'Si'
                                : 'No',
                            style: textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Patologias',
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            if (args.medicalInformationComplete.pathologies.isEmpty)
              Text('El paciente no presenta patologias'),
            if (args.medicalInformationComplete.pathologies.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: args.medicalInformationComplete.pathologies
                      .map((e) => Text(
                            '-> $e',
                            style: textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ))
                      .toList(),
                ),
              ),
            const SizedBox(height: 10.0),
            Text(
              'Presion arterial',
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            MedidaPresionInfo(
              medidaPresionPaciente: medidaPresionPaciente,
              bpmColor: AppColors.secondary,
            ),
            Spacer(),
            Row(
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RegistrarDiagnosticoScreen.route,
                        arguments: RegistrarDiagnosticoScreenArgs(
                          idMedicalRecord:
                              args.medicalInformationComplete.medicalRecordId,
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
          ],
        ),
      ),
    );
  }
}

class MedicalInformationCompleteScreenArgs {
  final MedicalInformationComplete medicalInformationComplete;

  const MedicalInformationCompleteScreenArgs({
    required this.medicalInformationComplete,
  });
}
