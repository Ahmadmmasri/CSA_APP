import 'package:csa_app/core/helpers/extensions.dart';
import 'package:csa_app/core/routing/routes.dart';
import 'package:csa_app/core/theming/colors.dart';
import 'package:csa_app/core/theming/styles.dart';
import 'package:csa_app/core/utility/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DashboardAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool haveIcon;
  final bool haveLogo;
  final String? title;
  final bool hideBackButton;

  const DashboardAppBar({
    Key? key,
    required this.haveIcon,
    required this.haveLogo,
    this.title,
    required this.hideBackButton,
  }) : super(key: key);

  @override
  _DashboardAppBarState createState() => _DashboardAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  late bool haveNewNotification = false;
  Future<void> getNotificationState() async {
    bool s = await UserSharedPrefrences().getNewNotificationState();
    setState(() {
      haveNewNotification = s;
    });
  }

  Future<void> removeNotificationState() async {
    await UserSharedPrefrences().removeNewNotificationState();
    bool s = await UserSharedPrefrences().getNewNotificationState();
    setState(() {
      haveNewNotification = s;
    });
  }

  void navigateToNotificationScreen() {
    context.pushNamed(Routes.notificationScreen);
  }

  @override
  void initState() {
    super.initState();
    getNotificationState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // toolbarHeight: 80,
      shadowColor: Colors.black45,
      leading: !widget.hideBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorsManager.primary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : const SizedBox(),
      backgroundColor: Colors.white,
      centerTitle: widget.title != null,
      title: widget.haveIcon
          ? SvgPicture.asset(
              'assets/icons/logo-csa.svg',
              // semanticLabel: 'csa logo',
              width: 70.w,
              // height: 120.h,
              fit: BoxFit.contain,
            )
          : Text(
              widget.title == null ? 'CSA' : widget.title!,
              style: TextStyles.font22MagentaW500Weight.copyWith(
                color: ColorsManager.primary,
              ),
            ),
      actions: [
        widget.haveIcon
            ? Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/bell-icon.svg',
                      semanticsLabel: 'notification icon',
                      width: 35.w,
                    ),
                    onPressed: () async {
                      await removeNotificationState();
                      navigateToNotificationScreen();
                    },
                  ),
                  haveNewNotification
                      ? Positioned(
                          top: 15,
                          right: 25,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red, // Red color
                            ),
                          ),
                        )
                      : Container(),
                ],
              )
            : Container(),
      ],
    );
  }
}
