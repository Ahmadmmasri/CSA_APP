import 'package:carousel_slider/carousel_slider.dart';
import 'package:csa_app/core/helpers/color-converter.dart';
import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/program.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgramsSlider extends StatelessWidget {
  final List<Program> programs;
  const ProgramsSlider({super.key, required this.programs});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        initialPage: 1,
        viewportFraction: 0.52,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: false,
        autoPlay: false,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        padEnds: false,
        onPageChanged: (index, reason) {
          // debugPrint(index);
        },
      ),
      itemCount: programs.length,
      itemBuilder: (context, index, realIndex) {
        final program = programs[index];
        return ProgramCard(
          program: program,
        );
      },
    );
  }
}

class ProgramCard extends StatelessWidget {
  final Program program;
  const ProgramCard({
    super.key,
    required this.program,
  });

  @override
  Widget build(BuildContext context) {
    // Uint8List imagebase64 = base64.decode(program.img!);

    return Stack(
      children: [
        InkWell(
          onTap: () => context.pushNamed(Routes.programDetailsScreen,
              arguments: program),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: program.img!.isNotEmpty
                ? Image.memory(
                    program.img!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 230.h,
                  )
                : Image.asset(
                    'assets/icons/program-default.png',
                    width: MediaQuery.of(context).size.width / 2.2,
                    height: 230.h,
                    cacheWidth: 490,
                    cacheHeight: 558,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 124.w,
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: program.bannerColor!.isNotEmpty
                  ? ColorConverter.hexToColor(program.bannerColor!)
                  : ColorsManager.primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(0),
            child: Text(
              program.bannerName!.isNotEmpty
                  ? program.bannerName!
                  : S.of(context).noLevelDetails,
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: MediaQuery.of(context).size.width / 2.2,
            height: 35.h,
            color: ColorsManager.bluishWhite,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(0),
            child: Center(
              child: Text(
                program.name,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorsManager.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
