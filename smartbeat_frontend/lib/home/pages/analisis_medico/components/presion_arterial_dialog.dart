import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartbeat_frontend/shared/components/custom_dialog.dart';
import 'package:smartbeat_frontend/shared/components/custom_shadow_container.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class PresionArterialDialog extends StatefulWidget {
  const PresionArterialDialog({super.key});

  @override
  State<PresionArterialDialog> createState() => _PresionArterialDialogState();
}

class _PresionArterialDialogState extends State<PresionArterialDialog> {
  double _sliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CustomDialog(
      hasClose: false,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Mi presión arterial',
                  style: textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SvgPicture.asset(
                  AppImages.pulse,
                  width: 100.0,
                  height: 100.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomShadowContainer(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30.0),
                        borderRadius: BorderRadius.circular(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '128',
                              style: textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Sistólica',
                              style: textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textInputColor),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: CustomShadowContainer(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 30.0),
                        borderRadius: BorderRadius.circular(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '85',
                              style: textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Diastolica',
                              style: textTheme.displaySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textInputColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                Container(
                  height: 10,
                  child: Slider(
                    value: _sliderValue,
                    min: 0.0,
                    max: 100.0,
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                    activeColor: Colors.transparent,
                    inactiveColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green,
                        Colors.yellow,
                        Colors.red,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              color: AppColors.secondary,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recomendaciones',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                    ),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Nunc faucibus pellentesque amet in. Risus quis semper sit magna tellus vel curabitur et ipsum. Neque amet aliquet nunc nulla sem sit ac. Lorem ipsum dolor sit amet consectetur. Nunc faucibus pellentesque amet in. Risus quis semper sit magna tellus vel curabitur et ipsum. Neque amet aliquet nunc nulla sem sit ac.',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
