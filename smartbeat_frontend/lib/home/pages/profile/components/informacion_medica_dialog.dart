import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbeat_frontend/home/forms/info_medica_form.dart';
import 'package:smartbeat_frontend/home/models/req_medical_information.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/analisis_medico_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';
import 'package:smartbeat_frontend/shared/formatters/currency_formatter.dart';
import 'package:smartbeat_frontend/shared/utils/app_constants.dart';

class InformacionMedicaDialog extends StatefulWidget {
  final int consultaMedicaId;
  final int lastMedicalRecordId;

  const InformacionMedicaDialog({
    super.key,
    required this.consultaMedicaId,
    required this.lastMedicalRecordId,
  });

  @override
  State<InformacionMedicaDialog> createState() =>
      _InformacionMedicaDialogState();
}

class _InformacionMedicaDialogState extends State<InformacionMedicaDialog> {
  InfoMedicaForm _form = InfoMedicaForm();

  Future<void> updateFormWithInformacionMedicaForm() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? formString = prefs.getString(AppConstants.keyInfoApp);
    if (formString != null) {
      _form.patchValue(jsonDecode(formString));
    }
    print("Formulario : " + formString!);
  }

  @override
  void initState() {
    super.initState();
    updateFormWithInformacionMedicaForm();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        body: Padding(
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
              hintText: '0.00',
              keyboardType: const TextInputType.numberWithOptions(),
              inputFormatters: [CurrencyInputFormatter()],
              formControl: _form.talla,
              label: 'Talla',
            ),
            CustomReactiveTextField(
              hintText: '000.00',
              keyboardType: const TextInputType.numberWithOptions(),
              inputFormatters: [CurrencyInputFormatter()],
              label: 'Peso',
              formControl: _form.peso,
            ),
            Row(
              children: [
                const Text('¿Fumó esta semana?'),
                const Spacer(),
                ReactiveSwitch(
                  formControl: _form.fumasteEstaSemana,
                ),
              ],
            ),
            Row(
              children: [
                const Text('¿Realizaste actividad fisica?'),
                const Spacer(),
                ReactiveSwitch(
                  formControl: _form.realizasteActividadFisica,
                ),
              ],
            ),
            Row(
              children: [
                const Text('¿Tomó alcohol?'),
                const Spacer(),
                ReactiveSwitch(
                  formControl: _form.tomasteAlcohol,
                ),
              ],
            ),
            const SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
              onPressed: () async {
                ReqMedicalInformation reqMedicalInformation =
                    ReqMedicalInformation.from(_form.rawValue);
                Navigator.pushNamed(
                  context,
                  AnalisisMedicoScreen.route,
                  arguments: AnalisisMedicoScreenArgs(reqMedicalInformation,
                      widget.consultaMedicaId, widget.lastMedicalRecordId),
                );
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    ));
  }
}
