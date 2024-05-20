import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/login/ui/widget/custome_button.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class FailLoginDialog extends StatelessWidget {
  const FailLoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        S.of(context).failLoginDialogTitle,
        textAlign: TextAlign.center,
      ),
      titleTextStyle: TextStyles.font18BoldWeight.copyWith(
        color: ColorsManager.primary,
        height: 1.4,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(3),
            Text(
              S.of(context).failLoginDialogDetail,
            ),
            verticalSpace(15),
            CustomeButton(
              buttonTitle: S.of(context).okButton,
              background: ColorsManager.primary,
              fontColor: ColorsManager.white,
              onPress: () {
                Navigator.of(context).pop();
              },
              borderColor: ColorsManager.primary,
            ),
          ],
        ),
      ),
    );
  }
}
