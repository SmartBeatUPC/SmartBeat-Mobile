import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class HeaderSection extends StatelessWidget {
  final String pathImg;
  final String title;

  const HeaderSection({super.key, required this.pathImg, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 150.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.outlineVariant,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Image.asset(
                pathImg,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
