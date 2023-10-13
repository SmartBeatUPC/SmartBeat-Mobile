import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/components/form_section.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/components/footer_section.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';

class RegistroScreen extends StatelessWidget {
  static String route = 'registro_screen';

  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                '!Hola¡ Comienza tu\nregistro',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: FormSection(),
            ),
            const SizedBox(height: 25.0),
            const FooterSection(),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
