import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

class CustomReactiveTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final FormControl<dynamic> formControl;
  final bool obscure;
  final VoidCallback? onPressedIcon;
  final IconData? suffixIcon;
  final Map<String, String Function(Object)>? validationMessages;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final void Function(FormControl<dynamic>)? onChanged;
  final EdgeInsets padding;
  final Color color;
  final int? maxLength;
  final bool? filled;
  final Color? fillColor;

  const CustomReactiveTextField({
    super.key,
    required this.hintText,
    required this.formControl,
    required this.label,
    this.validationMessages,
    this.inputFormatters,
    this.keyboardType,
    this.obscure = false,
    this.onPressedIcon,
    this.suffixIcon,
    this.onChanged,
    this.padding = const EdgeInsets.only(top: 15.0),
    this.color = AppColors.primary,
    this.maxLength,
    this.filled,
    this.fillColor,
  });

  @override
  State<CustomReactiveTextField> createState() =>
      _CustomReactiveTextFieldState();
}

class _CustomReactiveTextFieldState extends State<CustomReactiveTextField> {
  bool _obscurePassword = true;

  void setPasswordVisible() =>
      setState(() => _obscurePassword = !_obscurePassword);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReactiveTextField(
            maxLength: widget.maxLength,
            cursorColor: widget.color,
            validationMessages: widget.validationMessages,
            obscureText: widget.obscure,
            formControl: widget.formControl,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            style: textTheme.displayLarge!.copyWith(color: widget.color),
            decoration: InputDecoration(
              filled: widget.filled,
              fillColor: widget.fillColor,
              labelText: widget.label,
              labelStyle: textTheme.displayLarge!
                  .copyWith(color: widget.color, fontWeight: FontWeight.w500),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.color.withOpacity(0.9)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.color),
              ),
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
              ),
              errorStyle: textTheme.displaySmall?.copyWith(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
              suffixIcon: IconButton(
                onPressed: widget.onPressedIcon,
                icon: Icon(widget.suffixIcon),
              ),
              hintText: widget.hintText,
              hintStyle: textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: widget.color.withOpacity(0.6)),
            ),
          ),
        ],
      ),
    );
  }
}
