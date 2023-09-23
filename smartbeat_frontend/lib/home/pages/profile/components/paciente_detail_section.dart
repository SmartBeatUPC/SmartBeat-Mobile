import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/home/components/custom_info_card.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class PacienteDetailSection extends StatelessWidget {
  const PacienteDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  '58 Años',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.acentText,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 2,
                child:
                Text('jlopez@gmail.com', textAlign: TextAlign.center),
              ),
              Flexible(
                flex: 1,
                child: Text('+51985748248', textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Flexible(
              child: CustomInfoCard(
                text: '90 kg',
                subtext: 'Peso',
                iconPath: AppImages.weight,
              ),
            ),
            Flexible(
              child: CustomInfoCard(
                text: '175',
                subtext: 'Talla',
                iconPath: AppImages.flat1,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Flexible(
              child: CustomInfoCard(
                text: '90 kg',
                subtext: 'Peso ideal',
                iconPath: AppImages.weight,
                colorSubText: Colors.green,
              ),
            ),
            Flexible(
              child: CustomInfoCard(
                text: '175',
                subtext: 'Peso ideal',
                iconPath: AppImages.flat1,
                colorSubText: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
