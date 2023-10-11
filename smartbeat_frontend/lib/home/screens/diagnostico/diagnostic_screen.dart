import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/diagnostic_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/diagnostic_state.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/custom_shadow_container.dart';
import 'package:smartbeat_frontend/shared/utils/utils.dart';

class DiagnosticScreen extends StatelessWidget {
  static String route = 'diagnostic_screen';
  final DiagnosticScreenArgs args;

  const DiagnosticScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomScaffold(
      useAppBar: true,
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) =>
            DiagnosticCubit()..getDiagnostic(args.medicalRecordId),
        child: BlocConsumer<DiagnosticCubit, DiagnosticState>(
          listener: (context, state) {
            if (state is DiagnosticFailure) {
              Navigator.pop(context);
              Utils.showSnackBar(context,
                  'Aun no se ha realizado un diagnostico, espere a su doctor.');
            }
          },
          builder: (context, state) {
            return state is DiagnosticSuccess
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Diagnostico Medico',
                          style: textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                              state.diagnostic.diagnostic.diagnosticResult,
                              style: textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w400)),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          'Prescripcion medica',
                          style: textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15.0),
                        if (state.diagnostic.medicalPrescriptions.isNotEmpty)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: state.diagnostic.medicalPrescriptions
                                  .map(
                                    (e) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: CustomShadowContainer(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${e.medicament}',
                                              style: textTheme.titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          'Duración: ${e.duration}'),
                                                      Spacer(),
                                                      Text('Via: ${e.via}'),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                          'Frecuencia: ${e.frequency}'),
                                                      Spacer(),
                                                      Text(
                                                        'Dosis: ${e.dosage}',
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        if (state.diagnostic.medicalPrescriptions.isEmpty)
                          Text('No se ha recetado ningun medicamento'),
                        Spacer(),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    HomeNavBarScreen.route, (_) => false,
                                    arguments: const HomeNavBarScreenArgs(
                                        indexPage: 1));
                              },
                              child: Text('Ir al home')),
                        )
                      ],
                    ),
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class DiagnosticScreenArgs {
  final int medicalRecordId;

  const DiagnosticScreenArgs({required this.medicalRecordId});
}
