import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/models/req_medical_information.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/body_indications_medicion.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/body_start_medicion.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';

enum TypeMedicion { Manual, Smartwatch }

class AnalisisMedicoScreen extends StatefulWidget {
  static String route = 'analisis_medico_screen';

  final AnalisisMedicoScreenArgs args;

  const AnalisisMedicoScreen({
    super.key,
    required this.args,
  });

  @override
  State<AnalisisMedicoScreen> createState() => _AnalisisMedicoScreenState();
}

class _AnalisisMedicoScreenState extends State<AnalisisMedicoScreen> {
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
              reqMedicalInformation: widget.args.reqMedicalInformation,
              consultaMedicaId: widget.args.consultaMedicaId,
              lastMedicalRecordId: widget.args.lastMedicalRecordId,
              useReqMedicalInformation: widget.args.useReqMedicalInformation,
            ),
    );
  }
}

class AnalisisMedicoScreenArgs {
  final ReqMedicalInformation reqMedicalInformation;
  final int consultaMedicaId;
  final int lastMedicalRecordId;
  final bool useReqMedicalInformation;

  const AnalisisMedicoScreenArgs(
    this.reqMedicalInformation,
    this.consultaMedicaId,
    this.lastMedicalRecordId, {
    this.useReqMedicalInformation = false,
  });
}
