import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartbeat_frontend/seguridad/screens/registro/screens/datos_personales_screen.dart';

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
}
