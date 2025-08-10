import 'package:flutter/material.dart';

import '../../utils/color_resources.dart';


class CustomButtonWithBorder extends StatelessWidget {
  final Function()? onTap;
  final String txt;
  final double width, height;
  final bool fillColor;

  const CustomButtonWithBorder({
    super.key,
    this.onTap,
    this.width = 160,
    this.height = 40,
    required this.txt,
    this.fillColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: fillColor ? AppColors.secandaryColor : AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: fillColor ? null : Border.all(width: 1, color: AppColors.secandaryColor)),
        child: Center(
            child: Text(
          txt,
          textAlign: TextAlign.center,
          style: TextStyle(color: fillColor ? Colors.white : AppColors.secandaryColor, fontSize: 14),
        )),
      ),
    );
  }
}




class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String txt;
  final double width, height, fontSize;
  final Color fillColor;
  final Color textColor;

  const CustomButton({
    super.key,
    this.onTap,
    this.width = 160,
    this.fontSize = 14,
    this.height = 40,
    required this.txt,
    required this.fillColor,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: fillColor ,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
              txt,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor, fontSize: fontSize),
            )),
      ),
    );
  }
}
