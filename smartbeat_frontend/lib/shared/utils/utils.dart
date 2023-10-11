import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message,
          {Color colorBackground = Colors.redAccent}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: colorBackground),
      );
}
