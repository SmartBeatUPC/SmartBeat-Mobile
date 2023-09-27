import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/seleccion_paciente_medico_screen.dart';
import 'package:smartbeat_frontend/seguridad/forms/registro_inicial_form.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';

class FormSection extends StatefulWidget {
  const FormSection({Key? key}) : super(key: key);

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final RegistroInicialForm _form = RegistroInicialForm();

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomReactiveTextField(
                  hintText: 'Email',
                  formControl: _form.email,
                  label: 'Email',
                ),
                CustomReactiveTextField.password(
                  hintText: 'Contraseña',
                  formControl: _form.password,
                  label: 'Contraseña',
                ),
                CustomReactiveTextField.password(
                  hintText: 'Confirma Contraseña',
                  formControl: _form.repetirPassword,
                  label: 'Confirma Contraseña',
                ),
              ],
            ),
          ),
          const SizedBox(height: 25.0),
          SizedBox(
            width: double.infinity,
            child: ReactiveFormConsumer(builder: (context, form, child) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, SeleccionPacienteMedicoScreen.route,
                      arguments: SeleccionPacienteMedicoArgs(_form));
                },
                child: const Text('Continuar'),
              );
            }),
          ),
        ],
      ),
    );
  }
}
