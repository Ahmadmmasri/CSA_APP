import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/shared-widgets/app-text-button.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/evalution-line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MotivationCircle extends StatelessWidget {
  final EvaluationLine pointValue;
  final String level;
  const MotivationCircle(
      {Key? key, required this.pointValue, required this.level})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(6.0),
          width: 130.w,
          height: 130.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff11B8FF),
                Color(0xff0084FF),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                pointValue.pointValue,
                style: TextStyles.font14WhiteBoldWeight,
              ),
              Text(
                "Motivation",
                style: TextStyles.font12MediumWeight.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                left: context.isArabic ? 10 : 0,
                right: context.isArabic ? 0 : 10),
            child: SizedBox(
              height: 180.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Level $level",
                    style: TextStyles.font14WhiteBoldWeight.copyWith(
                      color: ColorsManager.primary,
                    ),
                  ),
                  // Text(
                  //   "Joined on 2/2024",
                  //   style: TextStyles.font14WhiteBoldWeight.copyWith(
                  //     color: ColorsManager.primary,
                  //   ),
                  // ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Flexible(
                        child: AppTextButton(
                          buttonText: "Race ${pointValue.race}",
                          buttonHeight: 14.h,
                          backgroundColor: ColorsManager.blue,
                          textStyle: TextStyles.font10MediumWeight
                              .copyWith(color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Flexible(
                        child: AppTextButton(
                          buttonText: "Distance ${pointValue.distance} M",
                          buttonHeight: 14.h,
                          backgroundColor: ColorsManager.blue,
                          textStyle: TextStyles.font10MediumWeight.copyWith(
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: AppTextButton(
                      buttonText: "Date of update ${pointValue.lastUpdateDate}",
                      buttonHeight: 14.h,
                      backgroundColor: ColorsManager.blue,
                      textStyle: TextStyles.font10MediumWeight.copyWith(
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
