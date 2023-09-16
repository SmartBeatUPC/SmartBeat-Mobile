import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/components/form_section.dart';
import 'package:smartbeat_frontend/seguridad/screens/login/components/header_section.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';

class LoginScreen extends StatelessWidget {
  static String route = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50),
            HeaderSection(),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: FormSection(),
            ),
          ],
        ),
      ),
    );
  }
}
