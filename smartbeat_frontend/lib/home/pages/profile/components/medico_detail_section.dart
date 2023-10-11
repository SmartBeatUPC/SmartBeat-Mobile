import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/medical_information_complete_cubit.dart';
import 'package:smartbeat_frontend/home/components/custom_info_card.dart';
import 'package:smartbeat_frontend/home/models/consulta_medica.dart';
import 'package:smartbeat_frontend/home/models/medical_information_complete.dart';
import 'package:smartbeat_frontend/home/screens/medical_information_complete_screen.dart';
import 'package:smartbeat_frontend/shared/extensions/string_extension.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class MedicoDetailSection extends StatefulWidget {
  final List<ConsultaMedica> listConsultaMedica;

  const MedicoDetailSection({super.key, required this.listConsultaMedica});

  @override
  State<MedicoDetailSection> createState() => _MedicoDetailSectionState();
}

class _MedicoDetailSectionState extends State<MedicoDetailSection> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = BlocProvider.of<MedicalInformationCompleteCubit>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'Cardiologa en Apolo Hospital',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.textInputColor,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Text(
              '4.5',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            SizedBox(width: 5.0),
            Text(
              '(17 reviews)',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.textInputColor,
                  ),
            )
          ],
        ),
        SizedBox(height: 10.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(
                  Icons.phone,
                  size: 20.0,
                ),
              ),
              Container(
                height: 25.0,
                width: 0.5,
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(
                  Icons.email,
                  size: 20.0,
                ),
              ),
              Container(
                height: 25.0,
                width: 0.5,
                color: Colors.grey,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Icon(
                  Icons.share,
                  size: 20.0,
                ),
              ),
            ],
          ),
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
                  cubit.fetch(consulta.consultation.id);
                  /*
                  MedicalInformationComplete medicalInformationComplete =
                      MedicalInformationComplete(
                          height: "80.0",
                          weight: "80.0",
                          smoke: true,
                          bmi: "95.0",
                          alcohol: true,
                          sedentary: false,
                          bloodPressureSistolic: "92.0",
                          bloodPressureDiastolic: "85.0",
                          pathologies: [
                        "Fumo diario",
                        "Tomo alcohol todos los fines de semana",
                      ]);

                  Navigator.pushNamed(
                    context,
                    MedicalInformationCompleteScreen.route,
                    arguments: MedicalInformationCompleteScreenArgs(
                      medicalInformationComplete: medicalInformationComplete,
                    ),
                  );
                   */
                },
                title: RichText(
                  text: TextSpan(
                    text: 'Paciente: ',
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
                      fontWeight: FontWeight.w600, color: AppColors.secondary),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
