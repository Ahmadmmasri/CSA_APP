import 'package:csa_app/features/Dashboard/internal-pages/home/data/main-branch.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/branch.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/header-section.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcademyBranch extends StatelessWidget {
  final List<MainBranch> branchs;

  const AcademyBranch({super.key, required this.branchs});

  // void _loadMainBranch() async {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          HeaderSection(title: S.of(context).ourbranches, hideViewAll: true),
          Branch(branches: branchs),
        ],
      ),
    );
  }
}
