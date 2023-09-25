import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class TypeUserCard extends StatelessWidget {
  final String pathImage;
  final String label;
  final Color textBoxColor;
  final VoidCallback onTap;
  final double scaleImage;
  final BoxFit fitImage;

  const TypeUserCard({
    super.key,
    required this.pathImage,
    required this.label,
    required this.textBoxColor,
    required this.onTap,
    this.scaleImage = 1.0,
    this.fitImage = BoxFit.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
              color: AppColors.outlineVariant.withOpacity(0.5), width: 1.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTap,
        child: Ink(
          width: 190.0,
          height: 180.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: fitImage,
              image: AssetImage(pathImage),
              scale: scaleImage,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: textBoxColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
