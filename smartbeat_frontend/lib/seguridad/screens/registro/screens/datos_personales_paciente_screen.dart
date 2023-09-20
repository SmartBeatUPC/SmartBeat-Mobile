import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/seguridad/forms/datos_personales_paciente_form.dart';
import 'package:smartbeat_frontend/shared/components/custom_reactive_text_field.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';

enum TypeUser{ Medico, Paciente}
class DatosPersonalesPacienteScreen extends StatefulWidget {
  static String route = 'datos_personales_paciente_screen';
  final DatosPersonalesPacienteScreenArgs args;

  const DatosPersonalesPacienteScreen({super.key, required this.args});

  @override
  State<DatosPersonalesPacienteScreen> createState() =>
      _DatosPersonalesPacienteScreenState();
}

class _DatosPersonalesPacienteScreenState
    extends State<DatosPersonalesPacienteScreen> {
  DatosPersonalesPacienteForm _form = DatosPersonalesPacienteForm();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
                      formControl: _form.nombre,
                      label: 'Nombre',
                    ),
                    CustomReactiveTextField(
                      hintText: 'Apellidos',
                      formControl: _form.apellidos,
                      label: 'Apellidos',
                    ),
                    CustomReactiveTextField(
                      hintText: 'Edad',
                      formControl: _form.edad,
                      label: 'Edad',
                    ),
                    CustomReactiveTextField(
                      hintText: 'DNI',
                      formControl: _form.dni,
                      label: 'DNI',
                    ),
                    CustomReactiveTextField(
                      hintText: 'Telefono',
                      formControl: _form.telefono,
                      label: 'Telefono',
                    ),
                    if(widget.args.typeUser == TypeUser.Paciente)
                    CustomReactiveTextField(
                        hintText: 'Nacionalidad',
                        formControl: _form.edad,
                        label: 'Nacionalidad'),
                    CustomReactiveTextField(
                      hintText: 'Genero',
                      formControl: _form.edad,
                      label: 'Genero',
                    ),
                    const SizedBox(height: 50.0),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Siguiente'),
            ),
          ),
        ],
      ),
    );
  }
}

class DatosPersonalesPacienteScreenArgs {
  final TypeUser typeUser;

  const DatosPersonalesPacienteScreenArgs({required this.typeUser});
}