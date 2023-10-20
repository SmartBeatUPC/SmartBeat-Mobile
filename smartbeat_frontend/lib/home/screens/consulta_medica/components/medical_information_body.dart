import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartbeat_frontend/home/models/medical_information_complete.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/medida_presion_info.dart';
import 'package:smartbeat_frontend/shared/components/custom_shadow_container.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/utils.dart';

class MedicalInformationBody extends StatelessWidget {
  final MedicalInformationComplete medicalInformationComplete;
  final bool showSectionPresionArterial;
  final String doctorPhone;

  const MedicalInformationBody({
    super.key,
    required this.medicalInformationComplete,
    this.showSectionPresionArterial = true,
    required this.doctorPhone,
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
                    Text('BMI:',
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    const Spacer(),
                    Text(medicalInformationComplete.bmi,
                        style: textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
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
                    Text(!medicalInformationComplete.sedentary ? 'Si' : 'No',
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
          Row(
            children: [
              Text(
                'Presión arterial',
                style: textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Utils.redirectToWsp(doctorPhone, context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.0),
                    Text('Contactar'),
                  ],
                ),
              ),
            ],
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
