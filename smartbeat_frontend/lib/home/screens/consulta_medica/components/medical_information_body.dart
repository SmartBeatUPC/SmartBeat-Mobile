import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/medical_information_complete.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/medida_presion_info.dart';
import 'package:smartbeat_frontend/shared/components/custom_shadow_container.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class MedicalInformationBody extends StatelessWidget {
  final MedicalInformationComplete medicalInformationComplete;
  final bool showSectionPresionArterial;

  const MedicalInformationBody({
    super.key,
    required this.medicalInformationComplete,
    this.showSectionPresionArterial = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    MedidaPresionPaciente medidaPresionPaciente = MedidaPresionPaciente(
      sys: medicalInformationComplete.bloodPressureSistolic,
      dia: medicalInformationComplete.bloodPressureDiastolic,
      bpm: medicalInformationComplete.heartRate,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informacion Medica',
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
          child: CustomShadowContainer(
            color: AppColors.primary.withOpacity(0.25),
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            borderRadius: BorderRadius.circular(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Altura:',
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    const Spacer(),
                    Text(medicalInformationComplete.height,
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
                    Text(medicalInformationComplete.weight,
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
                    Text(medicalInformationComplete.smoke ? 'Si' : 'No',
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    Text('¿ Toma alcohol ?',
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    const Spacer(),
                    Text(medicalInformationComplete.alcohol ? 'Si' : 'No',
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
                    Text(medicalInformationComplete.sedentary ? 'Si' : 'No',
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
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        if (medicalInformationComplete.pathologies.isEmpty)
          Text('No presenta patologías'),
        if (medicalInformationComplete.pathologies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: medicalInformationComplete.pathologies
                  .map((e) => Text(
                        '-> $e',
                        style: textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ))
                  .toList(),
            ),
          ),
        const SizedBox(height: 20.0),
        if (showSectionPresionArterial) ...[
          Text(
            'Presión arterial',
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          MedidaPresionInfo(
            medidaPresionPaciente: medidaPresionPaciente,
            bpmColor: AppColors.secondary,
          ),
        ]
      ],
    );
  }
}
