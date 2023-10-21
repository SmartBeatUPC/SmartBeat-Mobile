import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';
import 'package:smartbeat_frontend/shared/utils/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message,
          {Color colorBackground = Colors.redAccent}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: colorBackground),
      );

  static String formatearFecha(String fechaOriginal) {
    fechaOriginal = fechaOriginal.replaceAll("/", "-");
    DateTime fechaDateTime = DateTime.parse(fechaOriginal);
    final DateFormat formatoDeseado = DateFormat('dd MMM', 'es');
    String fechaFormateada = formatoDeseado.format(fechaDateTime);

    return fechaFormateada;
  }

  static String getImageProfile(String gender, TypeUser typeUser){
    return  'assets/${typeUser.name}-${gender.toLowerCase()}.png';
  }

  static redirectToWsp(String numero, BuildContext context) async {
    var wspUri = Uri.parse(
        'whatsapp://send?phone=${AppConstants.codigoPaisPeru}$numero&text=Hola!');
    if (await canLaunchUrl(wspUri)) {
      await launchUrl(wspUri, mode: LaunchMode.externalNonBrowserApplication);
    } else if (context.mounted) {
      Utils.showSnackBar(
          context, 'WhatsApp no esta instalado en este dispositivo');
    }
  }

  static void eliminarPatologiasInfoMedica() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
