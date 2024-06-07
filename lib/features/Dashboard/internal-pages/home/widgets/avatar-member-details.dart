import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarMemeberDetails extends StatelessWidget {
  const AvatarMemeberDetails({super.key, required this.member});
  final Member member;

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.of(context).size.width;
    final isImageEmpty = member.urlImage!.isEmpty;

    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            context.pushNamed(Routes.evalutionScreen, arguments: member);
          },
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager
                  .primarytinyLight, // Adjust the border color as needed
            ),
            child: ClipOval(
              child: SizedBox(
                width: screenwidth / 13.0.w * 2,
                height: screenwidth / 13.0.w * 2,
                child: isImageEmpty
                    ? Image.asset(
                        "assets/icons/member-default.png",
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        member.urlImage!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ),
        verticalSpace(10),
        Text(
          member.name,
          style: TextStyles.font14RegularWeight.copyWith(
            color: ColorsManager.primary,
          ),
        ),
      ],
    );
  }
}
