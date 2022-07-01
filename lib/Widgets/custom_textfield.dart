import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final Color? textColor;
  final Color? iconColor;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool? enabled;
  final int? maxLength;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool obscureText;

  const CustomTextField(
      {Key? key,
        this.validator,
      required this.hintText,
      required this.prefixIcon,
      this.enabled,
      this.keyboardType,
      this.obscureText=false,
      this.maxLength,
      this.initialValue,
      this.onChanged,
      this.controller,
      this.iconColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      enabled: enabled,
      controller: controller,
      onChanged: onChanged,
      maxLength: maxLength,
      keyboardType: keyboardType,
      initialValue: initialValue,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(
          prefixIcon,
          color: iconColor,
        ),
        hintStyle: TextStyle(color: textColor, fontSize: 15),
      ),
    );
  }
}
