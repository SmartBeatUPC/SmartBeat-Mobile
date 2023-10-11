import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/register_diagnostic_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/register_diagnostic_state.dart';
import 'package:smartbeat_frontend/home/models/medical_prescription.dart';
import 'package:smartbeat_frontend/home/screens/home_nav_bar_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/custom_shadow_container.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/utils/utils.dart';

class RegistrarDiagnosticoScreen extends StatefulWidget {
  static String route = 'registrar_diagnostico_screen';
  final RegistrarDiagnosticoScreenArgs args;

  const RegistrarDiagnosticoScreen({
    super.key,
    required this.args,
  });

  @override
  State<RegistrarDiagnosticoScreen> createState() =>
      _RegistrarDiagnosticoScreenState();
}

class _RegistrarDiagnosticoScreenState
    extends State<RegistrarDiagnosticoScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (context) => RegisterDiagnosticCubit(),
      child: BlocConsumer<RegisterDiagnosticCubit, RegisterDiagnosticState>(
        listener: (context, state) {
          if (state is RegisterDiagnosticSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeNavBarScreen.route, (_) => false,
                arguments: const HomeNavBarScreenArgs());
            Utils.showSnackBar(
                context, 'Se realizó el diagnostico correctamente.',
                colorBackground: Colors.lightGreenAccent);
          }
          if (state is RegisterDiagnosticFailure) {
            Navigator.pop(context);
            Utils.showSnackBar(context,
                'Por favor vuelva a intentar su diagnostico en unos minutos.');
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<RegisterDiagnosticCubit>(context);

          return ReactiveForm(
            formGroup: cubit.diagnosticoForm,
            child: CustomScaffold(
              backgroundColor: Colors.white,
              useAppBar: true,
              body: Loading(
                isLoading: state is RegisterDiagnosticLoading,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomReactiveTextField(
                          hintText: 'Ingresa el diagnostico',
                          formControl: cubit.diagnosticoForm.diagnostico,
                          label: "Diagnostico",
                          maxLines: 7,
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Medicamentos: ',
                              style: textTheme.titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20.0),
                            IconButton(
                              onPressed: () async {
                                MedicalPrescription? medicalPrescriptions =
                                    await showDialog(
                                  context: context,
                                  builder: (context) => CustomDialog(
                                    hasClose: false,
                                    body: Center(
                                      child: ReactiveForm(
                                        formGroup:
                                            cubit.medicalPrescriptionsFrom,
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 5.0),
                                                Text('Nuevo Medicamento',
                                                    style: textTheme.titleLarge
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                const SizedBox(height: 15.0),
                                                CustomReactiveTextField(
                                                  hintText: 'Medicamento',
                                                  formControl: cubit
                                                      .medicalPrescriptionsFrom
                                                      .medicament,
                                                  label: 'Medicamento',
                                                ),
                                                CustomReactiveTextField(
                                                  hintText: 'Dosis',
                                                  formControl: cubit
                                                      .medicalPrescriptionsFrom
                                                      .dosage,
                                                  label: 'Dosis',
                                                ),
                                                CustomReactiveTextField(
                                                  hintText: 'via',
                                                  formControl: cubit
                                                      .medicalPrescriptionsFrom
                                                      .via,
                                                  label: 'via',
                                                ),
                                                CustomReactiveTextField(
                                                  hintText: 'frequency',
                                                  formControl: cubit
                                                      .medicalPrescriptionsFrom
                                                      .frequency,
                                                  label: 'frequency',
                                                ),
                                                CustomReactiveTextField(
                                                  hintText: 'duration',
                                                  formControl: cubit
                                                      .medicalPrescriptionsFrom
                                                      .duration,
                                                  label: 'duration',
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 20.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            ReactiveFormConsumer(
                                                                builder:
                                                                    (context,
                                                                        form,
                                                                        child) {
                                                          return ElevatedButton(
                                                            onPressed: cubit
                                                                    .medicalPrescriptionsFrom
                                                                    .valid
                                                                ? () {
                                                                    MedicalPrescription
                                                                        medicalPresciption =
                                                                        MedicalPrescription.from(cubit
                                                                            .medicalPrescriptionsFrom
                                                                            .rawValue);
                                                                    Navigator.pop(
                                                                        context,
                                                                        medicalPresciption);
                                                                  }
                                                                : null,
                                                            child:
                                                                Text('Guardar'),
                                                          );
                                                        }),
                                                      ),
                                                      const SizedBox(
                                                          width: 25.0),
                                                      Expanded(
                                                        child: OutlinedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              Text('Cancelar'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                if (medicalPrescriptions != null) {
                                  cubit.listMedicalPrescription
                                      .add(medicalPrescriptions);
                                  setState(() {});
                                }
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 35.0,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: cubit.listMedicalPrescription
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
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              cubit.registrarDiagnostic(
                                  widget.args.idMedicalRecord);
                            },
                            child: Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RegistrarDiagnosticoScreenArgs {
  final int idMedicalRecord;

  const RegistrarDiagnosticoScreenArgs({
    required this.idMedicalRecord,
  });
}
