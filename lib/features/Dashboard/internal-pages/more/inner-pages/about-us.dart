import 'dart:convert';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/about.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/inner-pages/widgets/team-memebr.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  final About aboutData;
  const AboutUsScreen({super.key, required this.aboutData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DashboardAppBar(
        title: "About CSA",
        haveIcon: false,
        haveLogo: false,
        hideBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(40),
            Center(
                child: aboutData.imgUrl.isEmpty
                    ? Image.asset('assets/icons/circler-logo.png')
                    : Image.memory(
                        base64.decode(aboutData.imgUrl),
                        fit: BoxFit.cover,
                      )),
            verticalSpace(20),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Champions Swimming Academy',
                  style: TextStyles.font18BoldWeight.copyWith(
                    color: ColorsManager.primary,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(aboutData.description,
                  style: TextStyles.font14RegularWeight.copyWith(
                    color: ColorsManager.black,
                  )),
            ),
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Swim Coaching Team',
                      style: TextStyles.font18BoldWeight.copyWith(
                        color: ColorsManager.primary,
                      ),
                    ),
                  ),
                ),
                verticalSpace(10),
                const TeamMember(
                  imgUrl: 'assets/icons/circler-logo.png',
                  name: 'Coach Munther Shtaiwi',
                  description:
                      '(MA degree in sports training, ASA level two from the National British Swimming Federation, lecturer for national coaches).',
                ),
                verticalSpace(10),
                const TeamMember(
                  imgUrl: 'assets/icons/circler-logo.png',
                  name: 'Coach Ehab Abu-Namreh',
                  description:
                      'Head coach for the HCY swimming club, previous National Team Swimming Coach, member at the Canadian Federation for professional coaches and official evaluator and lecturer for the national coaches from the Jordanian Olympics committee and a the Precedence of the Jordan Swimming Federation.',
                ),
                verticalSpace(100),
              ],
            )
          ],
        ),
      ),
    );
  }
}
