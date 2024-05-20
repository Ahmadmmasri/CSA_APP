import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/login/ui/widget/fixed_app_bar.dart';
import 'package:csa_app/features/login/ui/widget/mobile_input_form.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const FixedAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                  width: 160.w,
                  cacheWidth: 160,
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: context.isArabic
                      ? EdgeInsets.only(right: 20.w)
                      : EdgeInsets.only(left: 20.w),
                  child: Text(
                    S.of(context).mobileNumberTitle,
                    style: TextStyles.font14BlackRegularWeight.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 450.h,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MobileInputForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
