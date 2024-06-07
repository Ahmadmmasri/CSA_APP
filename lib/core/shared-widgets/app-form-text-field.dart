import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFormTextField extends StatelessWidget {
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enableBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;

  const AppFormTextField({
    super.key,
    this.focusedBorder,
    this.enableBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.contentPadding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 13.h,
            ),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.primary,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
        enabledBorder: enableBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.lightGrey,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
        hintStyle: hintStyle ?? TextStyles.font14WhiteBoldWeight,
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? ColorsManager.periwinkle,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyles.font14BlackRegularWeight,
    );
  }
}
