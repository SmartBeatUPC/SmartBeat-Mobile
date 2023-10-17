import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/medical_information_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/cubit/presion_ppg_cubit.dart';
import 'package:smartbeat_frontend/home/bloc/states/medical_information_state.dart';
import 'package:smartbeat_frontend/home/bloc/states/presion_ppg_state.dart';
import 'package:smartbeat_frontend/home/models/medical_information_req.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/models/req_medical_information.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/presion_arterial_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';
import 'package:smartbeat_frontend/shared/extensions/string_extension.dart';
import 'package:smartbeat_frontend/shared/formatters/currency_formatter.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class MedirPresionManualDialog extends StatefulWidget {
  final ReqMedicalInformation reqMedicalInformation;
  final int consultaMedicaId;

  const MedirPresionManualDialog({
    super.key,
    required this.reqMedicalInformation,
    required this.consultaMedicaId,
  });

  @override
  State<MedirPresionManualDialog> createState() =>
      _MedirPresionManualDialogState();
}

class _MedirPresionManualDialogState extends State<MedirPresionManualDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicalInformationCubit(),
      child: BlocConsumer<MedicalInformationCubit, MedicalInformationState>(
          listener: (context, state) {
        if (state is MedicalInformationSuccess) {
          MedidaPresionPaciente medidaPresionPaciente = MedidaPresionPaciente(
            sys: '${state.presionReq.bloodPressureSistolic}',
            dia: '${state.presionReq.bloodPressureDiastolic}',
            bpm: '${state.presionReq.bloodPresheartRatesureDiastolic}',
            fechaHora: DateTime.now().toString().format('dd MMM'),
          );
          Navigator.pop(
              context, [state.presionReq, state.medicalInformationPpg]);
          showDialog(
            context: context,
            builder: (context) => PresionArterialDialog(
              medidaPresionPaciente: medidaPresionPaciente,
              ppgClasification: state.medicalInformationPpg.ppgClasification,
              ppgBar: state.medicalInformationPpg.ppgBar,
            ),
          );
        }
      }, builder: (context, state) {
        final cubit = BlocProvider.of<MedicalInformationCubit>(context);
        if (state is MedicalInformationLoading) {
          return const CustomDialog(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return CustomDialog(
          size: DialogHeightSize.small,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Ingresa tus datos',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary),
                  ),
                  const SizedBox(height: 10.0),
                  CustomReactiveTextField(
                    formControl: cubit.presionForm.bloodPressureSistolic,
                    hintText: '000.0',
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [CurrencyInputFormatter(decimalPlaces: 1)],
                    label: 'SYS',
                  ),
                  const SizedBox(height: 5.0),
                  CustomReactiveTextField(
                    formControl: cubit.presionForm.bloodPressureDiastolic,
                    hintText: '000.0',
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputFormatters: [CurrencyInputFormatter(decimalPlaces: 1)],
                    label: 'DIA',
                  ),
                  const SizedBox(height: 5.0),
                  CustomReactiveTextField(
                    formControl:
                        cubit.presionForm.bloodPresheartRatesureDiastolic,
                    hintText: '000.0',
                    keyboardType: const TextInputType.numberWithOptions(),
                    label: 'BPM',
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        cubit.registrarInformacionMedica(
                          widget.consultaMedicaId,
                          widget.reqMedicalInformation,
                        );
                      },
                      child: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
