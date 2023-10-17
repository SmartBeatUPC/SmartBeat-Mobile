import 'dart:math';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smartbeat_frontend/shared/formatters/text_manipulation.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final int decimalPlaces;

  final NumberFormat _formatter;

  CurrencyInputFormatter({this.decimalPlaces = 2})
      : _formatter = NumberFormat.decimalPatternDigits(
          decimalDigits: decimalPlaces,
          locale: 'en-US',
        );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return textManipulation(
      oldValue,
      newValue,
      textInputFormatter: FilteringTextInputFormatter.digitsOnly,
      formatPattern: (String filteredString) {

        if (filteredString.isEmpty) return '';
        num number;
        number = int.tryParse(filteredString) ?? 0;
        if (decimalPlaces > 0) {
          number /= pow(10, decimalPlaces);
        }
        return _formatter.format(number);
      },
    );
  }
}
