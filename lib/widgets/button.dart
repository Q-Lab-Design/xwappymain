// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:xwappy/constants.dart';

// import '../colors.dart';

class Button extends StatelessWidget {
  Function()? onTap;
  String buttonText;
  double buttonWidth;
  Color? color;
  Color? loderColor;
  double? textSize;
  double? height;
  EdgeInsetsGeometry? padding;
  bool isLoading;
  BoxBorder? border;
  double radius;
  Color? textColor;
  bool? outline;

  Button(
      {super.key,
      this.onTap,
      this.buttonText = '',
      this.buttonWidth = 240,
      this.textSize,
      this.color,
      this.padding,
      this.isLoading = false,
      this.border,
      this.radius = 15,
      this.textColor,
      this.loderColor,
      this.outline,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading == true ? null : onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 25),
        height: height ?? 50,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: outline == true
              ? Colors.transparent
              : color ?? Constants.btnColor(),
          borderRadius: BorderRadius.circular(radius),
          border: border,
        ), //height != null ? (height! * 0.8) : 40,
        child: isLoading == true
            ? Transform.scale(
                scale: height != null ? (height! * 0.015) : 1,
                child: Center(
                  child: CircularProgressIndicator(
                    color: loderColor ?? Colors.white,
                  ),
                ),
              )
            : Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                      color: outline == true
                          ? color ?? const Color(0xff5F0DAD)
                          : textColor ?? Constants.btnTxtColor(),
                      fontSize: textSize ?? 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
      ),
    );
  }
}
