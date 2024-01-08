import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool isPass;
  final TextInputType keyboardType;
  final Color textColor;
  final bool isDisabled;
  final FontWeight fontWeight;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText = "",
    this.maxLines = 1,
    this.suffixIcon,
    this.isPass = false,
    this.textColor = textDarkColor,
    this.keyboardType = TextInputType.text,
    this.isDisabled = false,
    this.fontWeight = FontWeight.normal,
    this.maxLength,
    Function()? onEditingCompleted,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: isDisabled,
      obscureText: isPass,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
        ),
        hintStyle: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
        ),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.all(12),
        border: const OutlineInputBorder(),
      ),
      inputFormatters: inputFormatters,
    );
  }
}
