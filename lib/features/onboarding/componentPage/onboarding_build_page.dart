import 'package:csa_app/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingBuildPage extends StatelessWidget {
  // final String image;
  final String title;
  final String description;
  final String imageUrl;
  final Color titleColor;

  const OnBoardingBuildPage({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imageUrl,
            width: 300.w,
            height: 300.h,
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            title,
            style: TextStyles.font30And500Weight.copyWith(
              color: titleColor,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              description,
              style: TextStyles.font14BlackRegularWeight
                  .copyWith(height: 1.7, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
