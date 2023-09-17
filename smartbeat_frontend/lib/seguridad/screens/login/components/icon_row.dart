import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class IconRow extends StatelessWidget {
  final List<String> icons;
  final double iconSize;

  const IconRow({
    super.key,
    required this.icons,
    this.iconSize = 35.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: icons.map((icon) {
        return Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.outlineVariant,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: SvgPicture.asset(
              icon,
              width: iconSize,
              height: iconSize,
            ),
          ),
        );
      }).toList(),
    );
  }
}
