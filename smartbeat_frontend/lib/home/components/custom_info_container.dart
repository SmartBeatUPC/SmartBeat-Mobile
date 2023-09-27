import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class CustomInfoContainer extends StatelessWidget {
  final String text;
  final double? height;
  final FontWeight fontWeight;

  CustomInfoContainer(
      {required this.text, this.height, this.fontWeight = FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(25.0),
        ),
        height:
            height != null ? MediaQuery.of(context).size.height * 0.35 : null,
        child: SingleChildScrollView(
          child: Text(
            text,
            style: textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
