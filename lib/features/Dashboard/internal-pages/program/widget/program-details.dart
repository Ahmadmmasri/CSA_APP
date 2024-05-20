import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/program.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgramDetails extends StatelessWidget {
  final Program programDetails;

  const ProgramDetails({super.key, required this.programDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
          title: programDetails.name,
          haveIcon: false,
          haveLogo: false,
          hideBackButton: false),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              transitionOnUserGestures: true,
              tag: "avatar",
              child: programDetails.img!.isNotEmpty
                  ? Image.memory(
                      programDetails.img!,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 210.h,
                    )
                  : Image.asset(
                      'assets/icons/program-default.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: 210.h,
                      cacheWidth: 490,
                      cacheHeight: 558,
                    ),
            ),
            verticalSpace(5),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                programDetails.description!,
                style: TextStyles.font12MediumWeight.copyWith(
                  color: ColorsManager.black,
                  letterSpacing: 1.1,
                  height: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
