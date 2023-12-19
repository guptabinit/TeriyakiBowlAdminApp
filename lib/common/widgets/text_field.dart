import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomTextField extends StatefulWidget {
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

  const CustomTextField({super.key,
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
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      readOnly: widget.isDisabled,
      obscureText: widget.isPass,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: TextStyle(
              color: widget.textColor,
              fontWeight: widget.fontWeight
          ),
          hintStyle: TextStyle(
              color: widget.textColor,
              fontWeight: widget.fontWeight
          ),
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.all(12),
          border: const OutlineInputBorder()
      ),
    );
  }
}
