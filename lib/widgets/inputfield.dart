import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:xwappy/constants.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final String? label;
  final bool obscurePassword;
  final Widget? suffixIcon;
  final double? radius;
  final Color? filledColor;
  final Color? borderColor;
  final bool? readonly;
  final bool? isdense;
  final Function()? onTap;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final TextStyle? hintstyle;
  final TextStyle? labelstyle;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final InputBorder? border;
  final InputBorder? focussedborder;

  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;

  TextInputField(
      {super.key,
      this.hintText = '',
      this.obscurePassword = false,
      this.suffixIcon,
      this.radius,
      this.filledColor,
      this.borderColor,
      this.readonly,
      this.labelstyle,
      this.label,
      this.onTap,
      this.isdense,
      this.onChanged,
      this.prefixIcon,
      this.contentPadding,
      this.validator,
      this.keyboardType,
      this.maxLength,
      this.maxLines,
      this.textStyle,
      this.maxLengthEnforcement,
      this.isPassword = false,
      this.hintstyle,
      this.border,
      this.focussedborder,
      this.inputFormatters,
      this.controller});

  final RxBool showPassword = true.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        //do not remove this bellow
        //it is there so that getx wont show exception
        showPassword.value;
        return TextFormField(
          onTap: onTap,
          // key: key,

          readOnly: readonly ?? false,
          cursorColor: Constants.btnColor(),
          onChanged: onChanged,
          obscureText: isPassword ? showPassword.value : obscurePassword,
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: textStyle ??
              TextStyle(
                color: Constants.txtColor(),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
          inputFormatters: inputFormatters,
          textInputAction: TextInputAction.done,
          maxLines: isPassword || obscurePassword ? 1 : maxLines,
          maxLength: maxLength,
          maxLengthEnforcement: maxLengthEnforcement,
          decoration: InputDecoration(
              contentPadding: contentPadding,
              isDense: isdense,
              fillColor: filledColor,
              filled: filledColor != null ? true : null,
              errorMaxLines: 3,
              hintText: hintText,
              labelText: label,
              labelStyle: labelstyle ??
                  const TextStyle(
                    color: Color(0xFFA2A2A2),
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
              prefixIcon: prefixIcon,
              prefixIconColor: const Color(0xffBEC1CD),
              suffixIcon: isPassword
                  ? GestureDetector(
                      onTap: () {
                        showPassword.value = !showPassword.value;
                      },
                      child: Icon(showPassword.value
                          ? Entypo.eye_with_line
                          : Entypo.eye))
                  : suffixIcon,
              suffixIconColor: const Color(0xffBEC1CD),
              hintStyle: hintstyle ??
                  const TextStyle(
                    color: Color(0xFFA2A2A2),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
              counterText: "",
              focusedBorder: focussedborder ??
                  OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: borderColor ?? Constants.txtColor()!,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius ?? 16),
                      )),
              enabledBorder: border ??
                  OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: borderColor ?? Constants.txtColor()!,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius ?? 16),
                      )),
              border: border ??
                  OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Constants.txtColor()!,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(radius ?? 16), //C3C7E5
                      ))),
        );
      },
    );
  }
}
