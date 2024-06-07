import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/header-section.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/widgets/avatar-member-details.dart';

class ClubMemebrs extends StatelessWidget {
  final List<Member> memberFuture;

  const ClubMemebrs({super.key, required this.memberFuture});

  @override
  Widget build(BuildContext context) {
    List<AvatarMemeberDetails> membersList =
        memberFuture.map((e) => AvatarMemeberDetails(member: e)).toList();
    return Container(
      color: const Color(0xffEBEDF5),
      height: 170.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: HeaderSection(
              title: S.of(context).members,
              hideViewAll: false,
              onTapViewAllButton: () async => context.pushNamed(
                Routes.allMemebrScreen,
                arguments: memberFuture,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: ListView.builder(
                itemCount: membersList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: membersList[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
