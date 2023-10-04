import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/login_cubit.dart';
import 'package:smartbeat_frontend/seguridad/forms/login_form.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';

class FormSection extends StatefulWidget {
  const FormSection({Key? key}) : super(key: key);

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  late LoginForm _form;

  @override
  void initState() {
    super.initState();
    _form = BlocProvider.of<LoginCubit>(context).loginForm;
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
                  hintText: 'Email',
                  formControl: _form.email,
                  label: 'Email',
                ),
                CustomReactiveTextField.password(
                  hintText: 'Contraseña',
                  formControl: _form.password,
                  label: 'Contraseña',
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '¿Olvidaste la contraseña?',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25.0),
          SizedBox(
            width: double.infinity,
            child: ReactiveFormConsumer(
              builder: (context, form, child) {
                return ElevatedButton(
                  onPressed: _form.valid
                      ? () => BlocProvider.of<LoginCubit>(context)
                  //TODO Cambiar si es online
                          .login(isOnline: false)
                      : null,
                  child: const Text('Ingresar'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
