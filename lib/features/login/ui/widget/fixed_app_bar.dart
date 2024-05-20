import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class FixedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FixedAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            S.of(context).loginHeaderScreenTitle,
            style: TextStyles.font22MagentaW500Weight,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.primary,
          ),
          onPressed: () {
            context.pop();
          },
        ),
      ),
    );
  }
}
