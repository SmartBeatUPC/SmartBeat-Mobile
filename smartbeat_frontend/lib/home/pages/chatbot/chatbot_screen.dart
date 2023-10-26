import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/prediction_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/prediction_save_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/prediction_save_state.dart';
import 'package:smartbeat_frontend/home/bloc/states/prediction_state.dart';
import 'package:smartbeat_frontend/home/components/custom_info_container.dart';
import 'package:smartbeat_frontend/home/pages/chatbot/components/chat_expanded.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/info_app_cubit.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class ChatBotScreen extends StatefulWidget {
  static String route = 'chat_bot_screen';
  final ChatBotScreenArgs args;

  const ChatBotScreen({super.key, required this.args});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final infoAppCubit = BlocProvider.of<InfoAppCubit>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PredictionCubit(),
        ),
        BlocProvider(
          create: (context) => PredictionSaveCubit(),
        )
      ],
      child: BlocConsumer<PredictionCubit, PredictionState>(
        listener: (context, state) {
          if (state is PredictionSuccess) {
            isExpanded = true;
          }
        },
        builder: (context, state) {
          return BlocConsumer<PredictionSaveCubit, PredictionSaveState>(
              listener: (contextSavePrediction, stateSavePrediction) {
            if (stateSavePrediction is PredictionSaveSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeNavBarScreen.route,
                (_) => false,
                arguments: const HomeNavBarScreenArgs(indexPage: 1),
              );
            }
          }, builder: (contextSavePrediction, stateSavePrediction) {
            return Loading(
              isLoading: state is PredictionLoading ||
                  stateSavePrediction is PredictionSaveLoading,
              child: CustomScaffold(
                useAppBar: true,
                body: state is PredictionSuccess
                    ? ChatExpanded(
                        textPrediction: state.prediction.responseAssistance,
                        medicalInformationId: widget.args.medicalInformationId,
                        doctorLastName: widget.args.doctorLastName,
                        lastMedicalRecordId: widget.args.lastMedicalRecordId,
                      )
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
                                  BlocProvider.of<PredictionCubit>(context)
                                      .predict(
                                          infoAppCubit.infoApp.typeUser!,
                                          infoAppCubit.infoApp.dataUser!.id!,
                                          widget.args.medicalInformationId);
                                },
                                child: const Text('Click Aquí para comenzar')),
                          ),
                        ],
                      ),
              ),
            );
          });
        },
      ),
    );
  }
}

class ChatBotScreenArgs {
  final int medicalInformationId;
  final String doctorLastName;
  final int lastMedicalRecordId;

  const ChatBotScreenArgs({
    required this.medicalInformationId,
    required this.doctorLastName,
    required this.lastMedicalRecordId,
  });
}
