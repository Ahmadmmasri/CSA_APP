import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:csa_app/features/login/ui/widget/custome_button.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    CsaAuthCubit phoneAuthCubit = CsaAuthCubit();
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        S.of(context).logOutButton,
        textAlign: TextAlign.center,
      ),
      titleTextStyle: TextStyles.font18BoldWeight.copyWith(
        color: ColorsManager.primary,
        height: 1.4,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpace(3),
            Text(
              S.of(context).logOutDialogMessage,
            ),
            verticalSpace(15),
            BlocProvider<CsaAuthCubit>(
              create: (context) => CsaAuthCubit(),
              child: CustomeButton(
                buttonTitle: S.of(context).logOutDialogConfirm,
                background: ColorsManager.primary,
                fontColor: ColorsManager.white,
                onPress: () async {
                  await phoneAuthCubit.logOut();
                  if (context.mounted) {
                    context.pushNamedAndRemoveUntil(
                      Routes.welcomeScreenLogin,
                      predicate: (route) => false,
                    );
                  }
                },
                borderColor: ColorsManager.primary,
              ),
            ),
            verticalSpace(15),
            CustomeButton(
              buttonTitle: S.of(context).logOutDialogCancel,
              background: ColorsManager.white.withOpacity(0.1),
              fontColor: ColorsManager.primary,
              onPress: () {
                Navigator.of(context).pop();
              },
              borderColor: ColorsManager.primary,
            )
          ],
        ),
      ),
    );
  }
}
