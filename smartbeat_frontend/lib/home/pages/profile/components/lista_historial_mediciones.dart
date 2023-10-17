import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class HistorialMedicionesList extends StatefulWidget {
  final List<HistorialMedicion> mediciones;
  final Function(HistorialMedicion)? onTapRowHistorialMedicion;

  const HistorialMedicionesList({
    super.key,
    required this.mediciones,
    this.onTapRowHistorialMedicion,
  });

  @override
  State<HistorialMedicionesList> createState() =>
      _HistorialMedicionesListState();
}

class _HistorialMedicionesListState extends State<HistorialMedicionesList> {
  int selectedItemIndex = -1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(5.0),
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
        children: widget.mediciones.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final medicion = entry.value;

            return Material(
              color: Colors.white.withOpacity(0.0),
              child: Column(
                children: [
                  InkWell(
                    autofocus: true,
                    splashColor: AppColors.primary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      if (widget.onTapRowHistorialMedicion != null) {
                        widget.onTapRowHistorialMedicion!(medicion);
                      }
                      setState(() {
                        selectedItemIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedItemIndex == index
                            ? AppColors.primary.withOpacity(0.35)
                            : null,
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 15.0, top: 10.0, left: 5.0, right: 5.0),
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
                              medicion.ppg.ppgDate,
                              style: textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (index + 1 != widget.mediciones.length)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: const Divider(
                        height: 1.0,
                        color: Colors.black,
                      ),
                    ),
                ],
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
