import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final Function()? onTap;
  final double paddingH;
  final double paddingV;
  final bool isDisabled;
  final Color backgroundColor;
  final Color textColor;

  const CustomButton({
    Key? key,
    required this.btnText,
    required this.onTap,
    this.paddingH = 24,
    this.paddingV = 16,
    this.isDisabled = false,
    this.backgroundColor = primaryColor,
    this.textColor = lightColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: isDisabled ? Colors.grey : backgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: isDisabled ? (){} : onTap,
        child: Container(
          padding:
          EdgeInsets.symmetric(vertical: paddingV, horizontal: paddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                btnText,
                style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
