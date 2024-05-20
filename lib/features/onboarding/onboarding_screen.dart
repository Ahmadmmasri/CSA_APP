import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/features/onboarding/components/get_start_buttons.dart';
import 'package:csa_app/features/onboarding/componentPage/onboarding_build_page.dart';
import 'package:csa_app/features/onboarding/widgets/bottom_indicator.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> boardingPages = [
      OnBoardingBuildPage(
        title: S.of(context).onBoardingOneTitle,
        titleColor: ColorsManager.purble,
        description: S.of(context).onBoardingOneContent,
        imageUrl: 'assets/images/onboarding_1.png',
      ),
      OnBoardingBuildPage(
        title: S.of(context).onBoardingTwoTitle,
        titleColor: ColorsManager.orange,
        description: S.of(context).onBoardingTwoContent,
        imageUrl: 'assets/images/onboarding_2.png',
      ),
      OnBoardingBuildPage(
        title: S.of(context).onBoardingThreeTitle,
        titleColor: ColorsManager.lightBlue,
        description: S.of(context).onBoardingThreeContent,
        imageUrl: 'assets/images/onboarding_3.png',
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(bottom: 100.h),
          child: PageView(
            onPageChanged: (value) => setState(() {
              isLastPage = value == boardingPages.length - 1;
            }),
            controller: pageController,
            children: [...boardingPages],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        height: 130.h,
        child: isLastPage
            ? AnimatedBuilder(
                animation: pageController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0.0,
                        pageController.page! - pageController.page!.floor()),
                    child: const GetStartButtons(),
                  );
                },
              )
            : BottomIndicator(
                pageController: pageController,
              ),
      ),
    );
  }
}
