import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/prediction_cubit.dart';
import 'package:smartbeat_frontend/home/components/custom_info_container.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class ChatExpanded extends StatelessWidget {
  final String textPrediction;

  const ChatExpanded({super.key, required this.textPrediction});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(250.0),
              ),
              width: MediaQuery.of(context).size.width * 0.25,
              child: Image.asset(
                AppImages.chatbot,
              ),
            ),
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
                      horizontal: 20.0, vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            //TODO Obtener el tipo de usuario y enviar datos de usuario
                            BlocProvider.of<PredictionCubit>(context)
                                .predict(TypeUser.patient);
                          },
                          child: Text('Generar nuevo'),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text('Aceptar'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
