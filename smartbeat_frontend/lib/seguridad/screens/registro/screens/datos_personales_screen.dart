import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/register_cubit.dart';
import 'package:smartbeat_frontend/seguridad/bloc/state/register_state.dart';
import 'package:smartbeat_frontend/seguridad/forms/registro_inicial_form.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/screens/login_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_dropdown_field.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';
import 'package:smartbeat_frontend/shared/components/loading.dart';
import 'package:smartbeat_frontend/shared/models/option.dart';

enum TypeUser { doctor, patient }

class DatosPersonalesScreen extends StatefulWidget {
  static String route = 'datos_personales_screen';
  final DatosPersonalesScreenArgs args;

  const DatosPersonalesScreen({super.key, required this.args});

  @override
  State<DatosPersonalesScreen> createState() => _DatosPersonalesScreenState();
}

class _DatosPersonalesScreenState extends State<DatosPersonalesScreen> {
  List<Option> optionsNacionalidad = [
    const Option(value: 'peru', text: 'Peru'),
    const Option(value: 'chile', text: 'Chile'),
    const Option(value: 'argentina', text: 'Argentina'),
    const Option(value: 'ecuatoriano', text: 'Ecuatoriano'),
  ];
  List<Option> optionsGenero = [
    const Option(value: 'masculino', text: 'Masculino'),
    const Option(value: 'femenino', text: 'Femenino'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushNamed(
            context,
            LoginScreen.route,
          );
        }
      }, builder: (context, state) {
        final cubit = BlocProvider.of<RegisterCubit>(context);
        final form = cubit.datosPersonalesUsuarioForm;

        return Loading(
          isLoading: state is RegisterLoading,
          child: CustomScaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                const SizedBox(height: 10.0),
                Text(
                  'Datos personales',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 40.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomReactiveTextField(
                            hintText: 'Nombre',
                            formControl: form.name,
                            label: 'Nombre',
                          ),
                          CustomReactiveTextField(
                            hintText: 'Apellidos',
                            formControl: form.lastName,
                            label: 'Apellidos',
                          ),
                          CustomReactiveTextField(
                            hintText: 'Edad',
                            formControl: form.age,
                            label: 'Edad',
                          ),
                          CustomReactiveTextField(
                            hintText: 'DNI',
                            formControl: form.dni,
                            label: 'DNI',
                          ),
                          CustomReactiveTextField(
                            hintText: 'Telefono',
                            formControl: form.telefono,
                            label: 'Telefono',
                          ),
                          if (widget.args.typeUser == TypeUser.patient)
                            CustomReactiveDropdownField(
                              formControl: form.nationality,
                              items: optionsNacionalidad,
                              hintText: 'Nacionalidad',
                            ),
                          CustomReactiveDropdownField(
                            formControl: form.gender,
                            items: optionsGenero,
                            hintText: 'Genero',
                          ),
                          const SizedBox(height: 50.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.registroForm = widget.args.registroInicialForm;
                      cubit.register();
                    },
                    child: const Text('Siguiente'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class DatosPersonalesScreenArgs {
  final TypeUser typeUser;
  final RegistroInicialForm registroInicialForm;

  const DatosPersonalesScreenArgs({
    required this.typeUser,
    required this.registroInicialForm,
  });
}
