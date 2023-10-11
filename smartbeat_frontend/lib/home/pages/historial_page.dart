import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/medida_presion_info.dart';
import 'package:smartbeat_frontend/shared/components/custom_gradient_background.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      useAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomGradientBackground(
            colors: [
              AppColors.primary.withOpacity(0.01),
              AppColors.primary.withOpacity(0.30),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Última medición',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                MedidaPresionInfo(
                  medidaPresionPaciente: MedidaPresionPaciente(
                      sys: '120',
                      dia: '80',
                      bpm: '70',
                      fechaHora: '11 de junio 2023 | 07:00hrs.'),
                  bpmColor: AppColors.primary,
                ),
                Spacer(),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1.0,
                        blurRadius: 25.0,
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Medir nuevamente',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondary
                          )
                        ),
                      ),
                      const Icon(Icons.refresh, size: 40.0,),
                      const SizedBox(width: 20.0)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 60.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Siguiente'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
