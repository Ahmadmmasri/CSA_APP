import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoResult extends StatelessWidget {
  const NoResult({super.key, this.title, this.description});
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animated/loading.json',
          width: 100.w,
          height: 100.h,
        ),
        Text(
          title ?? S.of(context).noLevelDetails,
          style: TextStyles.font16BoldWeight.copyWith(
            color: ColorsManager.primary,
          ),
        ),
        verticalSpace(18),
        Text(
          description ?? S.of(context).noLevelDetails,
          style: TextStyles.font14BlackRegularWeight.copyWith(
            color: ColorsManager.primarytinyMeduim,
          ),
        ),
      ],
    );
  }
}
