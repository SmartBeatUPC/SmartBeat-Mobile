import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico/analisis_medico_screen.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/components/type_user_card.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class SeleccionMedcionDialog extends StatelessWidget {
  const SeleccionMedcionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      size: DialogHeightSize.small,
      body: Column(
        children: [
          const SizedBox(height: 15.0),
          Text(
            'Medir mi presion con:',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold, color: AppColors.secondary),
          ),
          const SizedBox(
            height: 25.0,
          ),
          SizedBox(
            height: 150.0,
            width: 150.0,
            child: TypeUserCard(
              pathImage: AppImages.manualOption,
              label: TypeMedicion.Manual.name,
              textBoxColor: AppColors.primary,
              scaleImage: 1.15,
              fitImage: BoxFit.scaleDown,
              onTap: () {
                Navigator.of(context).pop(TypeMedicion.Manual);
              },
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          SizedBox(
            height: 150.0,
            width: 150.0,
            child: TypeUserCard(
              pathImage: AppImages.smartwatchOption,
              label: TypeMedicion.Smartwatch.name,
              textBoxColor: AppColors.secondary,
              scaleImage: 1.15,
              fitImage: BoxFit.scaleDown,
              onTap: () {
                Navigator.of(context).pop(TypeMedicion.Smartwatch);
              },
            ),
          ),
        ],
      ),
      hasClose: false,
    );
  }
}
