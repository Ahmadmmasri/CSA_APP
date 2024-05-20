import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/data/bar-item.dart';
import 'package:csa_app/features/Dashboard/internal-pages/elevate/widget/animated-circler-avtatar.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class BarTitle {
  static final List<BarItem> items = [
    // BarItem('B0', Color.fromARGB(255, 0, 3, 5)),
    // BarItem('B10', Color.fromARGB(255, 19, 192, 106)),
    // BarItem('B11', Color.fromARGB(255, 69, 9, 207)),
    // BarItem('B12', Color.fromARGB(255, 172, 231, 33)),
    // BarItem('B23', Color.fromARGB(255, 120, 212, 166)),
    BarItem('B1', const Color(0xff968694)),
    BarItem('B2', const Color(0xffC10230)),
    BarItem('A1', const Color(0xffC5A900)),
    BarItem('A2', const Color(0xffFFD600)),
    BarItem('A3', const Color(0xff38D430)),
    BarItem('A4', const Color(0xff6FCFEB)),
    BarItem('A5', const Color(0xff004A98)),
    BarItem('A6', const Color(0xff863399)),
    BarItem('C', const Color(0xff669FBB)),
    BarItem('ORCAS', const Color(0xff0E2DE0)),
  ];
}

class Diagrambars extends StatelessWidget {
  final Member member;
  const Diagrambars({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    var title = member.level!.name;
    barHeight(index) {
      return index == 0 ? 35.h : 35.h * (index + 1);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.8, //1.8 default
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 4,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: BarTitle.items.asMap().entries.map((entry) {
            final int index = entry.key;
            final BarItem item = entry.value;

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (BarTitle.items.length == index + 1)
                  Column(
                    children: [
                      if (item.title.toLowerCase() == title!.toLowerCase())
                        AnimatedCirclerAvatar(image: member.urlImage!),
                      Lottie.asset(
                        'assets/animated/castle.json',
                        width: 45.w,
                        height: 30.w,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                if (BarTitle.items.length != index + 1 &&
                    item.title.toLowerCase() == title!.toLowerCase())
                  Column(
                    children: [
                      AnimatedCirclerAvatar(image: member.urlImage!),
                      horizontalSpace(5),
                    ],
                  ),
                Container(
                  color: item.color,
                  // height: BarTitle.items.length == index + 1
                  //     ? barHeight(BarTitle.items.length)
                  //     : barHeight(index),
                  height: barHeight(index),
                  width: 25.w,
                  child: BarTitle.items.length == index + 1
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            BarTitle.items.last.title.length,
                            (index) {
                              return Text(
                                BarTitle.items.last.title[index],
                                style: TextStyles.font10MediumWeight.copyWith(
                                  color: ColorsManager.white,
                                  decoration: TextDecoration.none,
                                  height: 2,
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            item.title,
                            style: TextStyles.font10MediumWeight.copyWith(
                              color: ColorsManager.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
