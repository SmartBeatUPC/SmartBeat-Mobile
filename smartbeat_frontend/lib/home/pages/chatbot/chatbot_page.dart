import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/prediction_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/prediction_state.dart';
import 'package:smartbeat_frontend/home/components/custom_info_container.dart';
import 'package:smartbeat_frontend/home/pages/chatbot/components/chat_expanded.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PredictionCubit(),
      child: BlocConsumer<PredictionCubit, PredictionState>(
        listener: (context, state) {
          if (state is PredictionSuccess) {
            isExpanded = true;
          }
        },
        builder: (context, state) {
          return Loading(
            isLoading: state is PredictionLoading,
            child: CustomScaffold(
              useAppBar: true,
              body: state is PredictionSuccess
                  ? ChatExpanded(
                      textPrediction: state.prediction.responseAssistance)
                  : Column(
                      children: [
                        CustomInfoContainer(
                            text:
                                'Descubre SmartBeat, tu aliado personal para entender tu salud cardiovascular y manejar la hipertensión de manera inteligente.\n¡Sigue tu ritmo, vive con calma y lleva una vida plena y activa!'),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 40.0),
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
                              top: 40.0,
                              bottom: 20.0,
                              left: 20.0,
                              right: 20.0),
                          child: OutlinedButton(
                              onPressed: () {
                                //TODO Obtener el tipo de usuario y enviar datos de usuario
                                BlocProvider.of<PredictionCubit>(context)
                                    .predict(TypeUser.patient);
                              },
                              child: const Text('Click Aquí para comenzar')),
                        ),
                      ],
                    ),
            ),
          );
        },
      ),
    );
  }
}
