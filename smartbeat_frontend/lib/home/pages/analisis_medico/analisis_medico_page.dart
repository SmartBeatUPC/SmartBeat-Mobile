import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/body_indications_medicion.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/body_start_medicion.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';

enum TypeMedicion { Manual, Smartwatch }

class AnalisisMedicoPage extends StatefulWidget {
  const AnalisisMedicoPage({Key? key});

  @override
  State<AnalisisMedicoPage> createState() => _AnalisisMedicoPageState();
}

class _AnalisisMedicoPageState extends State<AnalisisMedicoPage> {
  TypeMedicion? typeSelected;
  MedidaPresionPaciente? medidaPresionPaciente;

  void onPressedStartMedicion(TypeMedicion? typeMedicion) {
    setState(() {
      typeSelected = typeMedicion;
    });
  }

  void onChangeMedidaPresionPaciente(MedidaPresionPaciente? medidaPresion) {
    setState(() {
      medidaPresionPaciente = medidaPresion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      useAppBar: true,
      body: typeSelected != null && medidaPresionPaciente == null
          ? BodyIndicationMedicion(
              typeSelected: typeSelected!,
              onChangeMedidaPresion: onChangeMedidaPresionPaciente,
            )
          : BodyStartMedicion(
        medidaPresionPaciente: medidaPresionPaciente,
        onPressedSelectTypeMedicion: onPressedStartMedicion,
              onChangeMedidaPresion: onChangeMedidaPresionPaciente,
            ),
    );
  }
}
