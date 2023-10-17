import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/medical_information_ppg.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/models/presion_req.dart';
import 'package:smartbeat_frontend/home/models/req_medical_information.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/analisis_medico_screen.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/asistente_medico_dialog.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/medida_presion_info.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/medir_presion_manual_dialog.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/seleccion_medicion_dialog.dart';
import 'package:smartbeat_frontend/home/screens/agregar_patologias_screen.dart';
import 'package:smartbeat_frontend/shared/extensions/string_extension.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class BodyStartMedicion extends StatefulWidget {
  final Function(TypeMedicion?) onPressedSelectTypeMedicion;
  final Function(MedidaPresionPaciente?) onChangeMedidaPresion;
  final MedidaPresionPaciente? medidaPresionPaciente;
  final ReqMedicalInformation reqMedicalInformation;
  final int consultaMedicaId;

  const BodyStartMedicion({
    super.key,
    required this.onPressedSelectTypeMedicion,
    required this.onChangeMedidaPresion,
    required this.medidaPresionPaciente,
    required this.reqMedicalInformation,
    required this.consultaMedicaId,
  });

  @override
  State<BodyStartMedicion> createState() => _BodyStartMedicionState();
}

class _BodyStartMedicionState extends State<BodyStartMedicion> {
  TypeMedicion? typeSelected;
  int? newMedicalInformationId;
  String? doctorLastName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        if (widget.medidaPresionPaciente != null) ...[
          const Spacer(),
          const Spacer(),
          const Spacer(),
        ],
        Text(
          'Medir la presión',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Image.asset(
          AppImages.splashIcon,
        ),
        if (widget.medidaPresionPaciente == null) ...[
          const Spacer(),
          const Spacer(),
          const Spacer(),
        ],
        if (typeSelected == null)
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: OutlinedButton(
                onPressed: () async {
                  TypeMedicion? typeSelected = await showDialog(
                    context: context,
                    builder: (context) => const SeleccionMedcionDialog(),
                  );
                  if (typeSelected == TypeMedicion.Manual) {
                    final resultMedirPresionManual = await showDialog(
                      context: context,
                      builder: (context) => MedirPresionManualDialog(
                        reqMedicalInformation: widget.reqMedicalInformation,
                        consultaMedicaId: widget.consultaMedicaId,
                      ),
                    );
                    PresionReq? presionReq = resultMedirPresionManual[0];
                    MedicalInformationPpg? medicalInformationPpg =
                        resultMedirPresionManual[1];
                    if (presionReq != null && medicalInformationPpg != null) {
                      widget.onChangeMedidaPresion(
                        MedidaPresionPaciente(
                          sys: '${presionReq.bloodPressureSistolic}',
                          dia: '${presionReq.bloodPressureDiastolic}',
                          bpm: '${presionReq.bloodPresheartRatesureDiastolic}',
                          fechaHora: DateTime.now().toString().format('dd MMM'),
                        ),
                      );
                      this.typeSelected = typeSelected;
                      newMedicalInformationId =
                          medicalInformationPpg.newMedicalInformationId;
                      doctorLastName = medicalInformationPpg.doctorLastName;
                      setState(() {});
                    }
                  } else {
                    setState(() {
                      this.typeSelected = typeSelected;
                      widget.onPressedSelectTypeMedicion(typeSelected);
                    });
                  }
                },
                child: const Text('Click Aquí para comenzar'),
              ),
            ),
          ),
        if (typeSelected != null) ...[
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1.0,
                  blurRadius: 25.0,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AgregarPatologiasScreen.route,
                  arguments: AgregarPatologiasScreenArgs(
                    medicalInformationId: newMedicalInformationId!,
                    doctorLastName: doctorLastName!,
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.add,
                    size: 30,
                  ),
                  const SizedBox(width: 10.0),
                  Text('Agregar Patologias',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AsistenteMedicoDialog(
                  newMedicalInformationId: newMedicalInformationId!,
                  doctorLastName: doctorLastName!,
                ),
              );
            },
            child: const Text('Continuar sin pantologias'),
          ),
          const SizedBox(height: 20.0),
        ],
        if (widget.medidaPresionPaciente != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: MedidaPresionInfo(
                medidaPresionPaciente: widget.medidaPresionPaciente!),
          )
      ],
    );
  }
}
