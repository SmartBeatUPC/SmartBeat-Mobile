import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/config/forms/validations_messages.dart';
import 'package:smartbeat_frontend/config/routes/routes.dart';
import 'package:smartbeat_frontend/config/theme/light_theme.dart';
import 'package:smartbeat_frontend/seguridad/screens/splash/screens/splash_screen.dart';

void main() {
  initializeDateFormatting('es_PE');
  Intl.defaultLocale = 'es';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: FormConfig.validationMessages,
      child: MaterialApp(
        title: 'SmartBeat App',
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.route,
        onGenerateRoute: (settings) =>
            CustomRoute.onGenerateRoute(settings),
      ),
    );
  }
}
