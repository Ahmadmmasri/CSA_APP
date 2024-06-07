import 'package:csa_app/features/Dashboard/internal-pages/home/data/program.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/header-section.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/programs-slider.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcademyProgram extends StatelessWidget {
  final List<Program> allPrograms;

  const AcademyProgram({super.key, required this.allPrograms});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          HeaderSection(
            title: S.of(context).OurPrograms,
            onTapViewAllButton: () {
              BlocProvider.of<CsaAuthCubit>(context).navigateAllPrograms();
            },
          ),
          ProgramsSlider(programs: allPrograms),
        ],
      ),
    );
  }
}
