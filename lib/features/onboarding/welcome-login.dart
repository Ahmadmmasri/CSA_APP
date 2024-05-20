import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/features/onboarding/componentPage/onboarding_build_page.dart';
import 'package:csa_app/features/onboarding/components/get_start_buttons.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class LoginWelcome extends StatelessWidget {
  const LoginWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OnBoardingBuildPage(
                  title: S.of(context).onBoardingThreeTitle,
                  titleColor: ColorsManager.lightBlue,
                  description: S.of(context).onBoardingThreeContent,
                  imageUrl: 'assets/images/onboarding_3.png',
                ),
                const GetStartButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
