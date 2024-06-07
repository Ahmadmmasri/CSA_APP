import 'package:csa_app/core/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BottomIndicator extends StatelessWidget {
  const BottomIndicator({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller: pageController,
        count: 3,
        effect: WormEffect(
          spacing: 13.w,
          dotWidth: 13.w,
          dotHeight: 13.w,
          dotColor: ColorsManager.lightGrey,
        ),
        onDotClicked: (index) => pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        ),
      ),
    );
  }
}
