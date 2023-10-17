import 'dart:math';
import 'package:flutter/services.dart';

TextEditingValue textManipulation(
  TextEditingValue oldValue,
  TextEditingValue newValue, {
  TextInputFormatter? textInputFormatter,
  String Function(String filteredString)? formatPattern,
}) {
  final originalUserInput = newValue.text;

  newValue = textInputFormatter != null
      ? textInputFormatter.formatEditUpdate(oldValue, newValue)
      : newValue;

  int selectionIndex = newValue.selection.end;

  final newText =
      formatPattern != null ? formatPattern(newValue.text) : newValue.text;

  if (newText == newValue.text) {
    return newValue;
  }

  int insertCount = 0;

  int inputCount = 0;

  bool isUserInput(String s) {
    if (textInputFormatter == null) return originalUserInput.contains(s);
    return newValue.text.contains(s);
  }

  for (int i = 0; i < newText.length && inputCount < selectionIndex; i++) {
    final character = newText[i];
    if (isUserInput(character)) {
      inputCount++;
    } else {
      insertCount++;
    }
  }

  selectionIndex += insertCount;
  selectionIndex = min(selectionIndex, newText.length);

  if (selectionIndex - 1 >= 0 &&
      selectionIndex - 1 < newText.length &&
      !isUserInput(newText[selectionIndex - 1])) {
    selectionIndex--;
  }

  return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
      composing: TextRange.empty);
}
