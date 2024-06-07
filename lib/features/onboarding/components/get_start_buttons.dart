import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/utility/shared_prefrences.dart';
import 'package:csa_app/features/onboarding/widgets/custome_button.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStartButtons extends StatelessWidget {
  const GetStartButtons({super.key});

  Future<void> hideIndecator() async {
    await UserSharedPrefrences().sethideIndecator();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          CustomeButton(
            buttonTitle: S.of(context).loginButton,
            onPress: () async {
              await hideIndecator();
              await context.pushNamed(Routes.loginScreen);
            },
            background: ColorsManager.primary,
            fontColor: ColorsManager.white,
            borderColor: ColorsManager.primary,
          ),
          SizedBox(height: 10.h),
          CustomeButton(
            buttonTitle: S.of(context).guestButton,
            onPress: () async {
              await hideIndecator();
              await context.pushNamed(Routes.dashboardScreen);
            },
            background: ColorsManager.white,
            fontColor: ColorsManager.primary,
            borderColor: ColorsManager.primary,
          ),
        ],
      ),
    );
  }
}
