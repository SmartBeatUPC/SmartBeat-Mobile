import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/prediction_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/prediction_save_cubit.dart';
import 'package:smartbeat_frontend/home/components/custom_info_container.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class ChatExpanded extends StatelessWidget {
  final int medicalInformationId;
  final int lastMedicalRecordId;
  final String textPrediction;
  final String doctorLastName;

  const ChatExpanded({
    super.key,
    required this.textPrediction,
    required this.medicalInformationId,
    required this.doctorLastName,
    required this.lastMedicalRecordId,
  });

  @override
  Widget build(BuildContext context) {
    final infoAppCubit = BlocProvider.of<InfoAppCubit>(context);
    final textTheme = Theme.of(context).textTheme;
    final predictionSaveCubit = BlocProvider.of<PredictionSaveCubit>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(250.0),
              ),
              width: MediaQuery.of(context).size.width * 0.425,
              child: Image.asset(
                AppImages.chatbot,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Text(
                'Asistente de: \n                $doctorLastName',
                style: textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(150.0),
                      ),
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Image.asset(
                        AppImages.chatbot,
                      ),
                    ),
                  ),
                  Flexible(
                    child: CustomInfoContainer(
                        fontWeight: FontWeight.w200,
                        height: MediaQuery.of(context).size.width * 0.2,
                        text: textPrediction),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 0.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              BlocProvider.of<PredictionCubit>(context).predict(
                                  TypeUser.patient,
                                  infoAppCubit.infoApp.dataUser!.id!,
                                  medicalInformationId);
                            },
                            child: Text('Generar nuevo'),
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeNavBarScreen.route,
                                (_) => false,
                                arguments: const HomeNavBarScreenArgs(),
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.home),
                                SizedBox(width: 5.0),
                                Text('Regresar'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          predictionSaveCubit.savePrediction(
                            infoAppCubit.infoApp.typeUser!,
                            textPrediction,
                            lastMedicalRecordId,
                          );
                        },
                        child: Text('Guardar respuesta')),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
