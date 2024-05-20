import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/program.dart';
import 'package:csa_app/features/Dashboard/internal-pages/program/widget/program-card.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ProgramScreen extends StatelessWidget {
  final List<Program> programs;

  const ProgramScreen({super.key, required this.programs});

  // void _loadPrograms() async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        title: S.of(context).OurPrograms,
        haveIcon: false,
        haveLogo: false,
        hideBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: ListView.builder(
            itemCount: programs.length,
            itemBuilder: (context, index) {
              return ProgramCard(
                program: programs[index],
              );
            }),
      ),
    );
  }
}
