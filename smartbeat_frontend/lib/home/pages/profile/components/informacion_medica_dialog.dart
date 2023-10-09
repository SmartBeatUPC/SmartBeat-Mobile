import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/medical_information_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_state.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/analisis_medico_screen.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';

class InformacionMedicaDialog extends StatefulWidget {
  final int consultaMedicaId;

  const InformacionMedicaDialog({super.key, required this.consultaMedicaId});

  @override
  State<InformacionMedicaDialog> createState() =>
      _InformacionMedicaDialogState();
}

class _InformacionMedicaDialogState extends State<InformacionMedicaDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      body: BlocProvider(
        create: (context) => MedicalInformationCubit(),
        child: BlocConsumer<MedicalInformationCubit, MedicalInformationState>(
            listener: (context, state) {
          if (state is MedicalInformationSuccess) {
            Navigator.pushNamed(
              context,
              AnalisisMedicoScreen.route,
              arguments:
                  AnalisisMedicoScreenArgs(state.newMedicalInformationId),
            );
          }
        }, builder: (context, state) {
          final cubit = BlocProvider.of<MedicalInformationCubit>(context);

          if (state is MedicalInformationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Informacion Medica',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15.0),
                  CustomReactiveTextField(
                    hintText: '0.0',
                    formControl: cubit.infoMedicaForm.talla,
                    label: 'Talla',
                  ),
                  CustomReactiveTextField(
                    hintText: '0.0',
                    formControl: cubit.infoMedicaForm.peso,
                    label: 'Peso',
                  ),
                  CustomReactiveTextField(
                    hintText: '0.0',
                    formControl: cubit.infoMedicaForm.imc,
                    label: 'IMC',
                  ),
                  Row(
                    children: [
                      const Text('¿Fumó esta semana?'),
                      const Spacer(),
                      ReactiveSwitch(
                        formControl: cubit.infoMedicaForm.fumasteEstaSemana,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('¿Realizaste actividad fisica?'),
                      const Spacer(),
                      ReactiveSwitch(
                        formControl:
                            cubit.infoMedicaForm.realizasteActividadFisica,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('¿Tomó alchool?'),
                      const Spacer(),
                      ReactiveSwitch(
                        formControl: cubit.infoMedicaForm.tomasteAlcohol,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cubit.registrarInformacionMedica(
                        widget.consultaMedicaId,
                      );
                    },
                    child: const Text('Guarder'),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
