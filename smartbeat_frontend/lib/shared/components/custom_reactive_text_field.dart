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
  final bool isPassword;
  final Color color;

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
  }) : isPassword = false;

  const CustomReactiveTextField.password({
    super.key,
    required this.hintText,
    required this.formControl,
    required this.label,
    this.validationMessages,
    this.inputFormatters,
    this.keyboardType,
    this.onChanged,
    this.padding = const EdgeInsets.only(top: 15.0),
    this.color = AppColors.primary,
  })  : obscure = true,
        suffixIcon = null,
        onPressedIcon = null,
        isPassword = true;

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
            cursorColor: widget.color,
            validationMessages: widget.validationMessages,
            obscureText: widget.isPassword ? _obscurePassword : widget.obscure,
            formControl: widget.formControl,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            style: textTheme.displayMedium!
                .copyWith(color: AppColors.textInputColor),
            decoration: InputDecoration(
              labelText: widget.label,
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
              labelStyle: textTheme.displayMedium!.copyWith(
                  color: AppColors.textInputColor, fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.color),
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              errorStyle: textTheme.displaySmall?.copyWith(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.textInputColor,
                      ),
                    )
                  : IconButton(
                      onPressed: widget.onPressedIcon,
                      icon: Icon(
                        widget.suffixIcon,
                        color: AppColors.textInputColor,
                      ),
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
