import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    Key? key,
    required this.title,
    this.hideViewAll = false,
    this.onTapViewAllButton,
    this.note,
  }) : super(key: key);

  final String title;
  final String? note;
  final bool hideViewAll;
  final VoidCallback? onTapViewAllButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyles.font14WhiteBoldWeight
              .copyWith(color: ColorsManager.primary),
        ),
        note != null
            ? Padding(
                padding: EdgeInsets.only(
                    left: context.isArabic ? 0 : 8,
                    right: context.isArabic ? 8 : 0),
                child: Text(
                  note!,
                  style: TextStyles.font10MediumWeight.copyWith(
                    color: ColorsManager.orange,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        if (!hideViewAll)
          TextButton(
            onPressed: onTapViewAllButton,
            child: Text(
              S.of(context).viewAll,
              style: TextStyles.font14WhiteBoldWeight.copyWith(
                color: ColorsManager.primary,
              ),
            ),
          ),
      ],
    );
  }
}
