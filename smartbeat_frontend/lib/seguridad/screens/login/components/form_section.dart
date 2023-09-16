import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/seguridad/forms/login_form.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';

class FormSection extends StatefulWidget {
  const FormSection({Key? key}) : super(key: key);

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  late LoginForm _form = LoginForm();

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
              children: <Widget>[
                CustomReactiveTextField(
                  hintText: 'DNI',
                  formControl: _form.dni,
                  label: 'DNI',
                  color: Colors.black,
                  maxLength: 8,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                CustomReactiveTextField(
                  hintText: 'Nombres',
                  formControl: _form.nombres,
                  label: 'Nombres',
                  color: Colors.black,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ReactiveFormConsumer(builder: (context, form, child) {
                return ElevatedButton(
                  onPressed: () {
                    //TODO Login
                  },
                  child: const Text('Ingresar'),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
