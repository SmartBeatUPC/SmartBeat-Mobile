import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/models/option.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class CustomReactiveDropdownField extends StatelessWidget {
  final FormControl<String> formControl;
  final List<Option> items;
  final String hintText;
  final EdgeInsets padding;
  final Color color;
  final Function(FormControl<String>, Option)? onChanged;
  final Map<String, String Function(Object)>? validationMessages;

  const CustomReactiveDropdownField({
    Key? key,
    required this.formControl,
    required this.items,
    required this.hintText,
    this.color = AppColors.outlineVariant,
    this.padding = const EdgeInsets.only(top: 15.0),
    this.onChanged,
    this.validationMessages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputDecorationTheme theme = Theme.of(context).inputDecorationTheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReactiveDropdownField<String>(
            isExpanded: false,
            validationMessages: validationMessages,
            elevation: 3,
            formControl: formControl,
            onChanged: (form) {
              Option option = items.firstWhere((e) => e.value == form.value);
              onChanged?.call(form, option);
            },
            decoration: InputDecoration(
              constraints: const BoxConstraints(minWidth: 130),
              hintText: hintText,
              border: const OutlineInputBorder(
                gapPadding: 8.0,
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              hintStyle: textTheme.displayMedium!.copyWith(
                  color: AppColors.textInputColor, fontWeight: FontWeight.bold),
              labelStyle: textTheme.displayMedium!.copyWith(
                  color: AppColors.textInputColor, fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: color),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            style: textTheme.displayMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: color.withOpacity(0.6),
            ),
            items: items.map((option) {
              return DropdownMenuItem<String>(
                key: key,
                value: option.value,
                child: RichText(
                  text: TextSpan(
                    text: option.text,
                    style: textTheme.displayMedium!.copyWith(
                      color: AppColors.textInputColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
