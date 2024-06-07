import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/font-weight-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static TextStyle font14BlackRegularWeight = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: ColorsManager.black,
  );

  static TextStyle font30And500Weight = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font14WhiteBoldWeight = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.white,
  );

  static TextStyle font14RegularWeight = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font12RegularWeight = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font12MediumWeight = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font12BoldWeight = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font10MediumWeight = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font9MediumWeight = TextStyle(
    fontSize: 9.sp,
    fontWeight: FontWeightHelper.medium,
  );

  static TextStyle font16BoldWeight = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font16RegularWeight = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
  );

  static TextStyle font18BoldWeight = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font22MagentaW500Weight = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.primary,
  );

  static TextStyle font80WhiteW500Weight = TextStyle(
    fontSize: 80.sp,
    fontWeight: FontWeightHelper.medium,
    color: ColorsManager.white,
  );
}
