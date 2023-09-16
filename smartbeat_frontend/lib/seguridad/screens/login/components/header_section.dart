import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/components/custom_shadow_container.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: CustomShadowContainer(
              width: 100.0,
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.asset(AppImages.splashIcon),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
