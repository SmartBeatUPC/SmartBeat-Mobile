import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/historial_medicion.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/card_info_presion_arterial.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/lista_historial_mediciones.dart';
import 'package:smartbeat_frontend/home/pages/profile/components/stacked_bar_chart.dart';

class DetailConsultaMedicaSection extends StatelessWidget {
  final List<HistorialMedicion> historialMediciones;

  const DetailConsultaMedicaSection({
    super.key,
    required this.historialMediciones,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        if(false)
        ...[
          Text(
            'Presión arterial',
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
          const CardInfoPresionArterial(sys: '120', dia: '80', bpm: '70'),
          const SizedBox(height: 20.0),
          StackedBarChart(
            progressValues: [80, 60, 90, 40, 70, 20, 50, 30],
            dates: [
              '10 Jun',
              '11 Jun',
              '12 Jun',
              '13 Jun',
              '14 Jun',
              '15 Jun',
              '16 Jun',
              '17 Jun'
            ],
          ),
          const SizedBox(height: 20.0),
          Text(
            'Historial de mediciones',
            style:
                textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: HistorialMedicionesList(mediciones: historialMediciones),
        ),
      ],
    );
  }
}
