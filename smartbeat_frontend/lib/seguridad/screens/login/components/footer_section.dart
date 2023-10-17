import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/seguridad/bloc/cubit/login_cubit.dart';
import 'package:smartbeat_frontend/seguridad/forms/login_form.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/registro_screen.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';
import 'package:smartbeat_frontend/shared/utils/app_images.dart';

import 'icon_row.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  late LoginForm _form;

  @override
  void initState() {
    super.initState();
    _form = BlocProvider.of<LoginCubit>(context).loginForm;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: AppColors.secondary.withOpacity(0.20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'O ingresa con',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: AppColors.secondary.withOpacity(0.20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        IconRow(icons: [
          AppImages.facebookSvg,
          AppImages.googleSvg,
          AppImages.appleSvg,
        ]),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ReactiveSwitch(
              formControl: _form.recordarDatos,
            ),
            const SizedBox(width: 15.0),
            Text(
              'Recuérdame',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(fontWeight: FontWeight.normal),
            )
          ],
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('¿No tienes cuenta?',
                style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(width: 5.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistroScreen.route);
              },
              child: const Text('Registrate ahora'),
            )
          ],
        ),
      ],
    );
  }
}
