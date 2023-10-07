import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class HistorialMedicionesList extends StatelessWidget {
  final List<HistorialMedicion> mediciones;

  HistorialMedicionesList({required this.mediciones});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.15),
              blurRadius: 7.0,
              spreadRadius: 4.0,
            ),
          ]),
      child: Column(
        children: mediciones
            .map(
              (medicion) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: medicion.ppg.bloodPressureSistolic,
                            style: textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                            children: [
                              TextSpan(
                                text: ' SYS',
                                style: textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textInputColor,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        RichText(
                          text: TextSpan(
                            text: medicion.ppg.bloodPressureDiastolic,
                            style: textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondary,
                            ),
                            children: [
                              TextSpan(
                                text: ' DIA',
                                style: textTheme.displaySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textInputColor),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '${medicion.ppg.heartRate}',
                          style: textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary,
                          ),
                        ),
                        Text(
                          medicion.ppg.ppgDate.substring(0, 10),
                          style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1.0,
                    color: Colors.black,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
