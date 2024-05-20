import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NoNotification extends StatelessWidget {
  const NoNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager.periwinkle
                  .withOpacity(0.2), // Replace with your desired color
            ),
            child: Center(
                child: SvgPicture.asset(
              'assets/icons/notification.svg',
              width: 80.w,
            )),
          ),
          horizontalSpace(12),
          Text(
            S.of(context).noNotificationsTitle,
            style: TextStyles.font16RegularWeight.copyWith(
              color: ColorsManager.primary,
            ),
          ),
          horizontalSpace(14),
          Text(
            S.of(context).noNotificationsSubTitle,
            style: TextStyles.font14RegularWeight
                .copyWith(color: ColorsManager.primarytinyMeduim),
          ),
        ],
      ),
    );
  }
}
