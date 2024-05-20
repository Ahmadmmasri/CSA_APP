import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/more/data/terms.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Terms term;

  const Details({super.key, required this.term});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        title: term.heade,
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
            Center(child: Image.asset('assets/icons/circler-logo.png')),
            verticalSpace(20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                term.name,
                style: TextStyles.font14RegularWeight.copyWith(
                  color: ColorsManager.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
