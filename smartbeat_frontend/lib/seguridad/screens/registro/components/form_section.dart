import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/seguridad/forms/registro_form.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class FormSection extends StatefulWidget {
  const FormSection({Key? key}) : super(key: key);

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  late RegistroForm _form = RegistroForm();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.transparent,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CustomReactiveTextField(
                  hintText: 'Usuario',
                  formControl: _form.usuario,
                  label: 'Usuario',
                  color: AppColors.outlineVariant,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                CustomReactiveTextField.password(
                  color: AppColors.outlineVariant,
                  hintText: 'Email',
                  formControl: _form.email,
                  label: 'Email',
                ),
                CustomReactiveTextField.password(
                  color: AppColors.outlineVariant,
                  hintText: 'Contraseña',
                  formControl: _form.password,
                  label: 'Contraseña',
                ),
                CustomReactiveTextField.password(
                  color: AppColors.outlineVariant,
                  hintText: 'Confirma Contraseña',
                  formControl: _form.password,
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
                  //TODO Registro
                },
                child: const Text('Registrarse'),
              );
            }),
          ),
        ],
      ),
    );
  }
}
