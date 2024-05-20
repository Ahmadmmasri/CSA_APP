import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/helpers/spacing.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/shared-widgets/dashboard_app_bar.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/features/Dashboard/internal-pages/account/widgets/logout-dialog.dart';
import 'package:csa_app/features/Dashboard/internal-pages/home/data/memeber.dart';
import 'package:csa_app/features/login/data/user-profile.dart';
import 'package:csa_app/features/login/logic/cubit/csa_auth_cubit.dart';
import 'package:csa_app/generated/l10n.dart';
import 'package:csa_app/hot-restart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountScreen extends StatelessWidget {
  final UserProfile? userinfo;
  final List<Member>? members;
  const AccountScreen({super.key, this.userinfo, this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        title: S.of(context).account,
        haveIcon: false,
        haveLogo: false,
        hideBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            userinfo!.childrenIds!.isNotEmpty
                ? Container(
                    height: 65.h,
                    decoration: const BoxDecoration(
                      color: ColorsManager.primary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text(
                            userinfo!.phone!,
                            style: TextStyles.font16RegularWeight.copyWith(
                              color: ColorsManager.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () async => context.pushNamed(
                              Routes.allMemebrScreen,
                              arguments: members
                              // await MemberController().initializeMemeber(),
                              // await MemberController().initializeMemeber();
                              ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              children: [
                                Text(
                                  S.of(context).members,
                                  style:
                                      TextStyles.font14RegularWeight.copyWith(
                                    color: ColorsManager.white,
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: ColorsManager.white,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
            verticalSpace(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          AssetImage('assets/icons/world-icon.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        S.of(context).appLanguage,
                        style: TextStyles.font16RegularWeight.copyWith(
                          color: ColorsManager.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<CsaAuthCubit, CsaAuthState>(
                  builder: (context, state) {
                    if (state is CurrentLang) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: TextButton(
                          onPressed: () {
                            if (state.locale.languageCode == "en") {
                              BlocProvider.of<CsaAuthCubit>(context)
                                  .switchLanguage("ar");
                            } else {
                              BlocProvider.of<CsaAuthCubit>(context)
                                  .switchLanguage("en");
                            }
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              HotRestartController.performHotRestart(context);
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(
                                  color: ColorsManager.primarytinyLight,
                                ),
                              ),
                            ),
                          ),
                          child: Text(
                            state.locale.languageCode,
                            style: TextStyles.font14RegularWeight.copyWith(
                              color: ColorsManager.primary,
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
            const Opacity(
              opacity: 0.2,
              child: Divider(),
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {
                    userinfo!.token != null
                        ? showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const LogoutDialog();
                            })
                        : context.pushNamed(Routes.loginScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundImage:
                              AssetImage('assets/icons/logout-icon.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            userinfo!.token != null
                                ? S.of(context).logOutButton
                                : S.of(context).loginButton,
                            style: TextStyles.font16RegularWeight.copyWith(
                              color: ColorsManager.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Opacity(
                  opacity: 0.6,
                  child: Divider(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
