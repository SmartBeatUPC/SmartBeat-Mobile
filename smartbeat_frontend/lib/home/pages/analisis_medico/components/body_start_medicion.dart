import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/models/medida_presion_paciente.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/analisis_medico_page.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/medida_presion_info.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/components/seleccion_medicion_dialog.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class BodyStartMedicion extends StatefulWidget {
  final Function(TypeMedicion?) onPressedSelectTypeMedicion;
  final Function(MedidaPresionPaciente?) onChangeMedidaPresion;
  final MedidaPresionPaciente? medidaPresionPaciente;

  const BodyStartMedicion({
    super.key,
    required this.onPressedSelectTypeMedicion,
    required this.onChangeMedidaPresion,
    required this.medidaPresionPaciente,
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
                  setState(() {
                    this.typeSelected = typeSelected;
                    widget.onPressedSelectTypeMedicion(typeSelected);
                  });
                },
                child: Text('Click Aquí para comenzar'),
              ),
            ),
          ),
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
