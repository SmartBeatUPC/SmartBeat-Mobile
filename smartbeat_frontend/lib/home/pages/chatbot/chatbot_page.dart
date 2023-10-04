import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/prediction_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/prediction_state.dart';
import 'package:smartbeat_frontend/home/components/custom_info_container.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PredictionCubit(),
      child: BlocConsumer<PredictionCubit, PredictionState>(
        listener: (context, state) {},
        builder: (context, state) {
          return CustomScaffold(
            useAppBar: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CustomInfoContainer(
                      text:
                          'Descubre SmartBeat, tu aliado personal para entender tu salud cardiovascular y manejar la hipertensión de manera inteligente.\n¡Sigue tu ritmo, vive con calma y lleva una vida plena y activa!'),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(250.0),
                      ),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Image.asset(
                        AppImages.chatbot,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        top: 40.0, bottom: 20.0, left: 20.0, right: 20.0),
                    child: OutlinedButton(
                        onPressed: () {
                          //TODO Obtener el tipo de usuario y enviar datos de usuario
                          BlocProvider.of<PredictionCubit>(context)
                              .predict(TypeUser.patient);
                        },
                        child: const Text('Click Aquí para comenzar')),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0)),
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
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  text:
                                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
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
                                  onPressed: () {},
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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
