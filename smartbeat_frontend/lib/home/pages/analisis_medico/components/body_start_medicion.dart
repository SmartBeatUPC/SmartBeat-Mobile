import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/models/presion_req.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/analisis_medico_screen.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/asistente_medico_dialog.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/medida_presion_info.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/medir_presion_manual_dialog.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/seleccion_medicion_dialog.dart';
import 'package:smartbeat_frontend/home/pages/chatbot/chatbot_screen.dart';
import 'package:smartbeat_frontend/home/screens/agregar_patologias_screen.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/extensions/string_extension.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class BodyStartMedicion extends StatefulWidget {
  final Function(TypeMedicion?) onPressedSelectTypeMedicion;
  final Function(MedidaPresionPaciente?) onChangeMedidaPresion;
  final MedidaPresionPaciente? medidaPresionPaciente;
  final int newMedicalInformationId;

  const BodyStartMedicion({
    super.key,
    required this.onPressedSelectTypeMedicion,
    required this.onChangeMedidaPresion,
    required this.medidaPresionPaciente,
    required this.newMedicalInformationId,
  });

  @override
  State<BodyStartMedicion> createState() => _BodyStartMedicionState();
}

class _BodyStartMedicionState extends State<BodyStartMedicion> {
  TypeMedicion? typeSelected;

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
                    PresionReq? presionReq = await showDialog(
                      context: context,
                      builder: (context) => MedirPresionManualDialog(
                          newMedicalInformationId:
                              widget.newMedicalInformationId),
                    );

                    if (presionReq != null) {
                      widget.onChangeMedidaPresion(
                        MedidaPresionPaciente(
                          sys: '${presionReq.bloodPressureSistolic}',
                          dia: '${presionReq.bloodPressureDiastolic}',
                          bpm: '${presionReq.bloodPresheartRatesureDiastolic}',
                          fechaHora: DateTime.now().toString().format('dd MMM'),
                        ),
                      );
                      this.typeSelected = typeSelected;

                      setState(() {});
                    }
                  } else {
                    setState(() {
                      this.typeSelected = typeSelected;
                      widget.onPressedSelectTypeMedicion(typeSelected);
                    });
                  }
                },
                child: Text('Click Aquí para comenzar'),
              ),
            ),
          ),
        if (typeSelected != null) ...[
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
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
                    medicalInformationId: widget.newMedicalInformationId,
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('Agregar Patologias',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary)),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AsistenteMedicoDialog(
                  newMedicalInformationId: widget.newMedicalInformationId,
                ),
              );
            },
            child: Text('Continuar sin pantologias'),
          ),
          SizedBox(
            height: 20.0,
          ),
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
