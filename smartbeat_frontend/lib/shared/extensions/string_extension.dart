import 'package:intl/intl.dart';

extension StringExtension on String {
  String format(String format, {String locale = 'es'}) {
    return DateFormat(format, locale).format(DateTime.parse(this));
  }

  String toTitlecase({String? exclude}) {
    if(isEmpty) return '';
    String newText = '';
    Map<int, String> textMap = trim().split(' ').asMap();
    for (String word in textMap.values) {
      if (exclude != null && word.contains(exclude)) {
        newText += word;
        continue;
      }
      newText += word.toLowerCase().replaceRange(0, 1, word[0].toUpperCase());
      if (word != textMap.values.last && textMap.values.length > 1) {
        newText += ' ';
      }
    }
    return newText.trimRight();
  }
}
