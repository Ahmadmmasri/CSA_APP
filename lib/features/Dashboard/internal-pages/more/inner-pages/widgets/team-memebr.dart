import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:flutter/material.dart';

class TeamMember extends StatelessWidget {
  const TeamMember(
      {super.key,
      required this.imgUrl,
      required this.name,
      required this.description});

  final String imgUrl;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imgUrl),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              name,
              style: TextStyles.font18BoldWeight.copyWith(
                color: ColorsManager.primary,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            textAlign: TextAlign.center,
            description,
            style: TextStyles.font14RegularWeight,
          ),
        )
      ],
    );
  }
}
